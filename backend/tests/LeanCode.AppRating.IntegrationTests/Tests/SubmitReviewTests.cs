using FluentAssertions;
using LeanCode.AppRating.Contracts;
using LeanCode.AppRating.IntegrationTests;
using LeanCode.AppRating.IntegrationTests.Helpers;
using Xunit;

namespace LeanCode.NotificationCenter.IntegrationTests.Tests;

public class SubmitReviewTests : TestBase
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
    }

    private async Task EnsureThatMetadataIsAcceptedCorrectly()
    {
        await Command.RunSuccessAsync(
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
        await Command.RunSuccessAsync(
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
        await Command.RunFailureAsync(
            new SubmitAppRating { AdditionalComment = new string('a', 4001), },
            SubmitAppRating.ErrorCodes.AdditionalCommentTooLong,
            SubmitAppRating.ErrorCodes.AppVersionRequired,
            SubmitAppRating.ErrorCodes.SystemVersionRequired,
            SubmitAppRating.ErrorCodes.RatingInvalid
        );
    }

    private Task<bool> UserAlreadySentRating()
    {
        return Query.GetAsync(new RatingAlreadySent { });
    }
}
