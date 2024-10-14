using System.Collections.Immutable;
using LeanCode.DomainModels.Ids;

namespace LeanCode.AppRating.DataAccess;

[TypedId(TypedIdFormat.RawGuid)]
public readonly partial record struct AppRatingId;

public sealed record class AppRating<TUserId>(
    AppRatingId Id,
    TUserId? UserId,
    DateTimeOffset DateCreated,
    double Rating,
    string? AdditionalComment,
    Platform Platform,
    string SystemVersion,
    string AppVersion,
    ImmutableDictionary<string, object>? Metadata
)
    where TUserId : notnull, IEquatable<TUserId>;

public enum Platform
{
    Android = 0,
    IOS = 1,
}
