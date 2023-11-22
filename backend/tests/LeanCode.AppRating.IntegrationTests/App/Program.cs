using LeanCode.AzureIdentity;
using LeanCode.Logging;
using LeanCode.Startup.MicrosoftDI;
using Microsoft.Extensions.Hosting;

namespace LeanCode.AppRating.IntegrationTests.App;

public static class Program
{
    public static IHostBuilder CreateHostBuilder(string[] args)
    {
        return LeanProgram
            .BuildMinimalHost<Startup>()
            .AddAppConfigurationFromAzureKeyVaultOnNonDevelopmentEnvironment()
            .ConfigureDefaultLogging(projectName: "test", destructurers: [ typeof(Program).Assembly ]);
    }
}
