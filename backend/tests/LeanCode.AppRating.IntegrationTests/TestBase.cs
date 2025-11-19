using System.Security.Claims;
using System.Text.Json;
using LeanCode.AppRating.IntegrationTests.App;
using LeanCode.CQRS.RemoteHttp.Client;
using LeanCode.IntegrationTestHelpers;
using LeanCode.Logging.AspNetCore;
using LeanCode.Startup.MicrosoftDI;
using Microsoft.Extensions.Hosting;
using Xunit;

namespace LeanCode.AppRating.IntegrationTests;

public abstract class TestsBase<TApp> : IAsyncLifetime, IDisposable
    where TApp : TestApp, new()
{
    protected TApp App { get; private set; }

    public TestsBase()
    {
        App = new();
    }

    Task IAsyncLifetime.InitializeAsync() => App.InitializeAsync().AsTask();

    Task IAsyncLifetime.DisposeAsync() => App.DisposeAsync().AsTask();

    void IDisposable.Dispose() => App.Dispose();
}

public class TestApp : LeanCodeTestFactory<App.Startup>
{
    public readonly Guid UserId = Guid.Parse("4d3b45e6-a2c1-4d6a-9e23-94e0d9f8ca01");

    protected HttpClient Client { get; set; }
    public HttpCommandsExecutor Command { get; set; }
    public HttpQueriesExecutor Query { get; set; }

    protected JsonSerializerOptions JsonSerializerOptions { get; } = new() { };

    protected override TestConnectionString ConnectionStringConfig =>
        TestDatabaseConfig.Create().GetTestConnectionString();

    public TestApp()
    {
        var claimsPrincipal = GetClaimsPrincipal(UserId);

        Client = CreateApiClient();
        Client.UseTestAuthorization(claimsPrincipal);

        Command = new HttpCommandsExecutor(Client, JsonSerializerOptions);
        Query = new HttpQueriesExecutor(Client, JsonSerializerOptions);
    }

    private static ClaimsPrincipal GetClaimsPrincipal(Guid userId)
    {
        return new ClaimsPrincipal(
            new ClaimsIdentity(
                new Claim[] { new(KnownClaims.UserId, userId.ToString()), new(KnownClaims.Role, Roles.User), },
                TestAuthenticationHandler.SchemeName,
                KnownClaims.UserId,
                KnownClaims.Role
            )
        );
    }

    protected HttpClient CreateUserClient(Guid userId)
    {
        var client = CreateApiClient();
        client.UseTestAuthorization(GetClaimsPrincipal(userId));
        return client;
    }

    protected override IHost CreateHost(IHostBuilder builder)
    {
        builder.UseContentRoot(Directory.GetCurrentDirectory());
        return base.CreateHost(builder);
    }

    protected override IHostBuilder CreateHostBuilder()
    {
        return LeanProgram
            .BuildMinimalHost<App.Startup>()
            .ConfigureDefaultLogging(projectName: "test", destructurers: [ typeof(Program).Assembly ])
            .UseEnvironment(Environments.Development);
    }
}
