using LeanCode.AppRating.Configuration;
using LeanCode.AppRating.EmailViewModels;
using LeanCode.SendGrid;
using MassTransit;
using SendGrid.Helpers.Mail;
using Serilog;

namespace LeanCode.AppRating.Handlers;

public class SendEmailOnLowRateSubmittedEH<TUserId> : IConsumer<LowRateSubmitted<TUserId>>
    where TUserId : notnull, IEquatable<TUserId>
{
    private readonly ILogger logger = Log.ForContext<SendEmailOnLowRateSubmittedEH<TUserId>>();
    private readonly SendGridRazorClient sendGridRazorClient;
    private readonly AppRatingReportsConfiguration appRatingReportsConfiguration;

    public SendEmailOnLowRateSubmittedEH(
        SendGridRazorClient sendGridRazorClient,
        AppRatingReportsConfiguration appRatingReportsConfiguration
    )
    {
        this.sendGridRazorClient = sendGridRazorClient;
        this.appRatingReportsConfiguration = appRatingReportsConfiguration;
    }

    public async Task Consume(ConsumeContext<LowRateSubmitted<TUserId>> context)
    {
        var vm = new LowRateSubmittedEmail
        {
            UserId = context.Message.UserId?.ToString(),
            AdditionalComment = context.Message.AdditionalComment,
            Rating = context.Message.Rating,
        };

        var message = new SendGridLocalizedRazorMessage(appRatingReportsConfiguration.LowRatingEmailCulture)
            .WithSubject(appRatingReportsConfiguration.LowRatingEmailSubjectKey)
            .WithSender(appRatingReportsConfiguration.FromEmail)
            .WithRecipients(
                appRatingReportsConfiguration.ToEmails.Select(e => new EmailAddress() { Email = e, }).ToList()
            )
            .WithHtmlContent(vm)
            .WithPlainTextContent(vm)
            .WithNoTracking();

        await sendGridRazorClient.SendEmailAsync(message, context.CancellationToken);
        logger.Information("Email about low rating from user {UserId} sent", context.Message.UserId);
    }
}

public sealed record class LowRateSubmitted<TUserId>(TUserId? UserId, double Rating, string? AdditionalComment)
    where TUserId : notnull, IEquatable<TUserId>;
