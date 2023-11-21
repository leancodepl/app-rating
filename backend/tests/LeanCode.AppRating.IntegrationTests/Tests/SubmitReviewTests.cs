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
        await Check_if_user_has_no_review_on_default();

        await Ensure_the_comment_max_length_is_validated();

        await Submit_correct_review();

        await Check_if_user_has_submitted_review();

        await Ensure_that_metadata_is_accepted_correctly();

        async Task Check_if_user_has_no_review_on_default()
        {
            var alreadySentRating = await Query.GetAsync(new RatingAlreadySent { });
            alreadySentRating.Should().BeFalse();
        }

        async Task Ensure_the_comment_max_length_is_validated()
        {
            await Command.RunFailureAsync(
                new SubmitAppRating { AdditionalComment = new string('a', 4001), },
                SubmitAppRating.ErrorCodes.AdditionalCommentTooLong
            );
        }

        async Task Submit_correct_review()
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

        async Task Check_if_user_has_submitted_review()
        {
            var alreadySentRating = await Query.GetAsync(new RatingAlreadySent { });
            alreadySentRating.Should().BeTrue();
        }

        async Task Ensure_that_metadata_is_accepted_correctly()
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
    }
}
