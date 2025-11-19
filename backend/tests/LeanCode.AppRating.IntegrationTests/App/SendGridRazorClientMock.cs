using LeanCode.SendGrid;
using SendGrid.Helpers.Mail;

namespace LeanCode.AppRating.IntegrationTests.App;

public class SendGridRazorClientMock : SendGridRazorClient
{
    public int SentEmailsCount { get; private set; }

    public SendGridRazorClientMock()
        : base(default!, default!, default!, default!)
    {
        SentEmailsCount = 0;
    }

    public override Task SendEmailAsync(SendGridMessage msg, CancellationToken cancellationToken = default)
    {
        SentEmailsCount++;
        return Task.CompletedTask;
    }
}
