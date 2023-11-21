using FluentAssertions;
using LeanCode.AppRating.Contracts;
using LeanCode.AppRating.IntegrationTests;
using Xunit;

namespace LeanCode.NotificationCenter.IntegrationTests.Tests;

public class SubmitReviewTests : TestBase
{
    [Fact]
    public async Task Review_is_submitted_correctly()
    {
        (await Query.GetAsync(new RatingAlreadySent { })).Should().BeFalse();

        var result = await Command.RunAsync(new SubmitAppRating { AdditionalComment = new string('a', 4001), });

        result.WasSuccessful.Should().BeFalse();

        result
            .ValidationErrors
            .Should()
            .ContainEquivalentOf(new { ErrorCode = SubmitAppRating.ErrorCodes.AdditionalCommentTooLong });

        (
            await Command.RunAsync(
                new SubmitAppRating
                {
                    Rating = 5.0,
                    AdditionalComment = new string('a', 200),
                    AppVersion = "1.23.456",
                    Platform = PlatformDTO.Android,
                    SystemVersion = "14",
                }
            )
        ).WasSuccessful.Should().BeTrue();

        (await Query.GetAsync(new RatingAlreadySent { })).Should().BeTrue();

        (
            await Command.RunAsync(
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
            )
        ).WasSuccessful.Should().BeTrue();
    }
}
