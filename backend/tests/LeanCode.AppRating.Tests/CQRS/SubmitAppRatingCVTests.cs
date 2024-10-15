using FluentValidation.TestHelper;
using LeanCode.AppRating.Contracts;
using LeanCode.AppRating.Handlers;
using Xunit;

namespace LeanCode.AppRating.Tests.CQRS;

public class SubmitAppRatingCVTests
{
    private SubmitAppRatingCV submitAppRating;

    public SubmitAppRatingCVTests()
    {
        submitAppRating = new SubmitAppRatingCV();
    }

    [Fact]
    public async Task Reports_error_when_rating_is_lower_than_1()
    {
        var x = await submitAppRating.TestValidateAsync(new SubmitAppRating { Rating = 0.9 });

        x.ShouldHaveValidationErrorFor(cmd => cmd.Rating);
    }

    [Fact]
    public async Task Reports_error_when_rating_is_higher_than_5()
    {
        var x = await submitAppRating.TestValidateAsync(new SubmitAppRating { Rating = 5.1 });

        x.ShouldHaveValidationErrorFor(cmd => cmd.Rating);
    }

    [Fact]
    public async Task Reports_error_when_system_version_is_missing()
    {
        var x = await submitAppRating.TestValidateAsync(new SubmitAppRating { SystemVersion = null! });

        x.ShouldHaveValidationErrorFor(cmd => cmd.SystemVersion);
    }

    [Fact]
    public async Task Reports_error_when_app_version_is_missing()
    {
        var x = await submitAppRating.TestValidateAsync(new SubmitAppRating { AppVersion = null! });

        x.ShouldHaveValidationErrorFor(cmd => cmd.AppVersion);
    }

    [Fact]
    public async Task Do_not_report_error_when_additional_comment_is_not_provided()
    {
        var x = await submitAppRating.TestValidateAsync(new SubmitAppRating { AdditionalComment = null });

        x.ShouldNotHaveValidationErrorFor(cmd => cmd.AdditionalComment);
    }

    [Fact]
    public async Task Do_not_report_error_when_additional_comment_has_max_length()
    {
        var x = await submitAppRating.TestValidateAsync(
            new SubmitAppRating { AdditionalComment = new string('a', 4000), }
        );

        x.ShouldNotHaveValidationErrorFor(cmd => cmd.AdditionalComment);
    }

    [Fact]
    public async Task Reports_error_when_additional_comment_exceeds_max_length()
    {
        var x = await submitAppRating.TestValidateAsync(
            new SubmitAppRating { AdditionalComment = new string('a', 4001), }
        );

        x.ShouldHaveValidationErrorFor(cmd => cmd.AdditionalComment);
    }
}
