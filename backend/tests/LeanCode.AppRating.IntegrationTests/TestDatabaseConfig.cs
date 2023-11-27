using LeanCode.AppRating.DataAccess;
using LeanCode.CQRS.MassTransitRelay.LockProviders;
using LeanCode.DomainModels.EF;
using LeanCode.IntegrationTestHelpers;
using MassTransit;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Npgsql;

namespace LeanCode.AppRating.IntegrationTests;

public abstract class TestDatabaseConfig
{
    public const string ConfigEnvName = "AppReviewIntegrationTests__Database";

    public abstract SqlDbType DbType { get; }
    public abstract ConfigurationOverrides GetConfigurationOverrides();
    public abstract void ConfigureDbContext(DbContextOptionsBuilder builder, IConfiguration config);

    public static TestDatabaseConfig Create()
    {
        return Environment.GetEnvironmentVariable(ConfigEnvName) switch
        {
            "sqlserver" => new SqlServerTestDatabaseConfig(),
            "postgres" => new PostgresTestConfig(),
            _
                => throw new InvalidOperationException(
                    $"Set the database provider (sqlserver|postgres) via {ConfigEnvName} env variable"
                ),
        };
    }
}

public class SqlServerTestDatabaseConfig : TestDatabaseConfig
{
    public override SqlDbType DbType => SqlDbType.MsSql;

    public override ConfigurationOverrides GetConfigurationOverrides() =>
        new("SqlServer__ConnectionStringBase", "SqlServer:ConnectionString");

    public override void ConfigureDbContext(DbContextOptionsBuilder builder, IConfiguration config)
    {
        builder.UseSqlServer(config.GetValue<string>("SqlServer:ConnectionString"));
    }
}

public class PostgresTestConfig : TestDatabaseConfig
{
    public override SqlDbType DbType => SqlDbType.PostgreSql;

    public override ConfigurationOverrides GetConfigurationOverrides() =>
        new("Postgres__ConnectionStringBase", "Postgres:ConnectionString");

    public override void ConfigureDbContext(DbContextOptionsBuilder builder, IConfiguration config)
    {
        var dataSource = new NpgsqlDataSourceBuilder(config.GetValue<string>("Postgres:ConnectionString"))
            .EnableDynamicJson()
            .Build();
        builder.UseNpgsql(dataSource);
    }
}
