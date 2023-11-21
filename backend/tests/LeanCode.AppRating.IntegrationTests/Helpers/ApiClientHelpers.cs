using System.Linq.Expressions;
using FluentAssertions;
using LeanCode.Contracts;
using LeanCode.Contracts.Validation;
using LeanCode.CQRS.RemoteHttp.Client;

namespace LeanCode.AppRating.IntegrationTests.Helpers;

public static class ApiClientHelpers
{
    public static async Task RunSuccessAsync(this HttpCommandsExecutor executor, ICommand command)
    {
        var result = await executor.RunAsync(command);
        result.ValidationErrors.Should().BeEmpty("command {0} needs to pass validation", command.GetType().Name);
    }

    public static async Task RunFailureAsync(
        this HttpCommandsExecutor executor,
        ICommand command,
        params int[] errorCodes
    )
    {
        var result = await executor.RunAsync(command);
        result.WasSuccessful.Should().BeFalse("command {0} is invalid", command.GetType().Name);
        result
            .ValidationErrors
            .Should()
            .Satisfy(errorCodes.Select<int, Expression<Func<ValidationError, bool>>>(e => r => r.ErrorCode == e));
    }
}
