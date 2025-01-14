using System.Security.Claims;
using LeanCode.AppRating.Configuration;
using LeanCode.Components;
using LeanCode.CQRS.AspNetCore;
using LeanCode.CQRS.MassTransitRelay;
using LeanCode.CQRS.Validation.Fluent;
using LeanCode.IntegrationTestHelpers;
using LeanCode.SendGrid;
using LeanCode.Startup.MicrosoftDI;
using MassTransit;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
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

            busCfg.AddAppRatingConsumers<Guid>();
        });

        var sendGridRazorClientMock = new SendGridRazorClientMock();

        services.AddSingleton<SendGridRazorClient>(sendGridRazorClientMock);
        services.AddSingleton(sendGridRazorClientMock);

        services.AddSingleton(
            new AppRatingReportsConfiguration(2.0, "en", "subject", "test+from@leancode.pl", [ "test+to@leancode.pl" ])
        );

        services.AddBusActivityMonitor();
    }

    protected override void ConfigureApp(IApplicationBuilder app)
    {
        app.UseRouting();
        app.UseAuthentication();

        app.UseEndpoints(endpoints =>
        {
            endpoints.MapRemoteCQRS(
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
    public bool TryExtract(HttpContext httpContext, out Guid userId)
    {
        var claim = httpContext.User.FindFirstValue(KnownClaims.UserId);

        ArgumentException.ThrowIfNullOrEmpty(claim);

        return Guid.TryParse(claim, out userId);
    }
}
