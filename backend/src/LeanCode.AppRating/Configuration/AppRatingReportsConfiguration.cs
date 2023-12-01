namespace LeanCode.AppRating.Configuration;

public sealed record class AppRatingReportsConfiguration(
    double LowRatingUpperBoundInclusive,
    string LowRatingEmailCulture,
    string LowRatingEmailSubjectKey,
    string FromEmail,
    string[] ToEmails
) { }
