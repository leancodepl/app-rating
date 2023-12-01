using FluentAssertions;
using LeanCode.AppRating.Contracts;
using LeanCode.AppRating.IntegrationTests;
using LeanCode.AppRating.IntegrationTests.App;
using LeanCode.AppRating.IntegrationTests.Helpers;
using Microsoft.Extensions.DependencyInjection;
using Xunit;

namespace LeanCode.NotificationCenter.IntegrationTests.Tests;

public class SubmitReviewTests : TestsBase<TestApp>
{
    [Fact]
    public async Task Review_is_submitted_correctly()
    {
        var alreadySentRating = await UserAlreadySentRating();
        alreadySentRating.Should().BeFalse();

        await EnsureValidationWorks();

        await SubmitCorrectReview();

        alreadySentRating = await UserAlreadySentRating();
        alreadySentRating.Should().BeTrue();

        await EnsureThatMetadataIsAcceptedCorrectly();

        await EnsureLowRatingSubmittedEmailSent();
    }

    private async Task EnsureThatMetadataIsAcceptedCorrectly()
    {
        await App.Command.RunSuccessAsync(
            new SubmitAppRating
            {
                Rating = 5.0,
                AdditionalComment = null,
                AppVersion = "1.23.456",
                Platform = PlatformDTO.Android,
                SystemVersion = "14",
                Metadata = new Dictionary<string, object>()
                {
                    ["foo"] = "bar",
                    ["foo2"] = new string[] { "baba1", "baba2" },
                    ["foo3"] = new { some = "object" },
                }
            }
        );
    }

    private async Task SubmitCorrectReview()
    {
        await App.Command.RunSuccessAsync(
            new SubmitAppRating
            {
                Rating = 5.0,
                AdditionalComment = new string('a', 200),
                AppVersion = "1.23.456",
                Platform = PlatformDTO.Android,
                SystemVersion = "14",
            }
        );
    }

    private async Task EnsureValidationWorks()
    {
        await App.Command.RunFailureAsync(
            new SubmitAppRating { AdditionalComment = new string('a', 4001), },
            SubmitAppRating.ErrorCodes.AdditionalCommentTooLong,
            SubmitAppRating.ErrorCodes.AppVersionRequired,
            SubmitAppRating.ErrorCodes.SystemVersionRequired,
            SubmitAppRating.ErrorCodes.RatingInvalid
        );
    }

    private Task<bool> UserAlreadySentRating()
    {
        return App.Query.GetAsync(new RatingAlreadySent { });
    }

    private async Task EnsureLowRatingSubmittedEmailSent()
    {
        await App.Command.RunSuccessAsync(
            new SubmitAppRating
            {
                Rating = 2.0,
                AdditionalComment = new string('a', 200),
                AppVersion = "1.23.456",
                Platform = PlatformDTO.Android,
                SystemVersion = "14",
            }
        );
        await App.WaitForBusAsync();

        App.Services.GetService<SendGridRazorClientMock>()!.SentEmailsCount.Should().Be(1);
    }
}
