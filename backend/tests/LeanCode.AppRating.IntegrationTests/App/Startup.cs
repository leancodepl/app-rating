using System.Security.Claims;
using LeanCode.Components;
using LeanCode.CQRS.AspNetCore;
using LeanCode.CQRS.MassTransitRelay;
using LeanCode.CQRS.Validation.Fluent;
using LeanCode.IntegrationTestHelpers;
using LeanCode.Startup.MicrosoftDI;
using MassTransit;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace LeanCode.AppRating.IntegrationTests.App;

public class Startup : LeanStartup
{
    public static readonly TypesCatalog Contracts = new(typeof(Startup)); // nothing
    public static readonly TypesCatalog Handlers = new(typeof(Startup)); // nothing
    private readonly TestDatabaseConfig testDatabaseConfig;

    public Startup(IConfiguration config)
        : base(config)
    {
        testDatabaseConfig = TestDatabaseConfig.Create();
    }

    public override void ConfigureServices(IServiceCollection services)
    {
        services.AddHostedService<DbContextInitializer<TestDbContext>>();
        services.AddDbContext<TestDbContext>(cfg => testDatabaseConfig.ConfigureDbContext(cfg, Configuration));
        services.AddFluentValidation(Handlers);
        services.AddCQRS(Contracts, Handlers).AddAppRating<Guid, TestDbContext, UserIdExtractor>();

        services.AddRouting();

        services.AddAuthentication(TestAuthenticationHandler.SchemeName).AddTestAuthenticationHandler();

        services.AddCQRSMassTransitIntegration(busCfg =>
        {
            InMemoryConfigurationExtensions.UsingInMemory(
                busCfg,
                (ctx, cfg) =>
                {
                    RegistrationContextExtensions.ConfigureEndpoints(cfg, ctx);
                }
            );
        });
    }

    protected override void ConfigureApp(IApplicationBuilder app)
    {
        app.UseRouting();
        app.UseAuthentication();

        app.UseEndpoints(endpoints =>
        {
            endpoints.MapRemoteCqrs(
                "/api",
                cqrs =>
                {
                    cqrs.Commands = c => c.Validate().CommitTransaction<TestDbContext>();
                }
            );
        });
    }
}

public sealed class UserIdExtractor : IUserIdExtractor<Guid>
{
    public Guid Extract(HttpContext httpContext)
    {
        var claim = httpContext.User.FindFirstValue(KnownClaims.UserId);

        ArgumentException.ThrowIfNullOrEmpty(claim);

        return Guid.Parse(claim);
    }
}
