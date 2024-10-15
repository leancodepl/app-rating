using System.Collections.Immutable;
using FluentValidation;
using LeanCode.AppRating.Configuration;
using LeanCode.AppRating.Contracts;
using LeanCode.AppRating.DataAccess;
using LeanCode.CQRS.Execution;
using LeanCode.CQRS.Validation.Fluent;
using LeanCode.TimeProvider;
using MassTransit;
using Microsoft.AspNetCore.Http;

namespace LeanCode.AppRating.Handlers;

public class SubmitAppRatingCV : AbstractValidator<SubmitAppRating>
{
    public SubmitAppRatingCV()
    {
        RuleFor(cmd => cmd.Rating).InclusiveBetween(1, 5).WithCode(SubmitAppRating.ErrorCodes.RatingInvalid);

        RuleFor(cmd => cmd.Platform).IsInEnum().WithCode(SubmitAppRating.ErrorCodes.PlatformInvalid);

        RuleFor(cmd => cmd.AdditionalComment)
            .MaximumLength(4000)
            .WithCode(SubmitAppRating.ErrorCodes.AdditionalCommentTooLong);
        RuleFor(cmd => cmd.SystemVersion)
            .NotEmpty()
            .WithCode(SubmitAppRating.ErrorCodes.SystemVersionRequired)
            .MaximumLength(200)
            .WithCode(SubmitAppRating.ErrorCodes.SystemVersionTooLong);
        RuleFor(cmd => cmd.AppVersion)
            .NotEmpty()
            .WithCode(SubmitAppRating.ErrorCodes.AppVersionRequired)
            .MaximumLength(200)
            .WithCode(SubmitAppRating.ErrorCodes.AppVersionTooLong);
    }
}

public class SubmitAppRatingCH<TUserId> : ICommandHandler<SubmitAppRating>
    where TUserId : notnull, IEquatable<TUserId>
{
    private readonly IAppRatingStore<TUserId> store;
    private readonly IUserIdExtractor<TUserId> extractor;
    private readonly IPublishEndpoint publishEndpoint;
    private readonly AppRatingReportsConfiguration appRatingReportsConfiguration;

    public SubmitAppRatingCH(
        IAppRatingStore<TUserId> store,
        IUserIdExtractor<TUserId> extractor,
        IPublishEndpoint publishEndpoint,
        AppRatingReportsConfiguration appRatingReportsConfiguration
    )
    {
        this.store = store;
        this.extractor = extractor;
        this.publishEndpoint = publishEndpoint;
        this.appRatingReportsConfiguration = appRatingReportsConfiguration;
    }

    public async Task ExecuteAsync(HttpContext context, SubmitAppRating command)
    {
        var userId = extractor.TryExtract(context, out var uid) ? uid : default;

        store
            .AppRatings
            .Add(
                new AppRating<TUserId>(
                    AppRatingId.New(),
                    userId,
                    Time.NowWithOffset,
                    command.Rating,
                    command.AdditionalComment,
                    (Platform)command.Platform,
                    command.SystemVersion,
                    command.AppVersion,
                    command.Metadata?.ToImmutableDictionary()
                )
            );

        if (command.Rating <= appRatingReportsConfiguration.LowRatingUpperBoundInclusive)
        {
            await publishEndpoint.Publish(
                new LowRateSubmitted<TUserId>(userId, command.Rating, command.AdditionalComment),
                context.RequestAborted
            );
        }
    }
}
