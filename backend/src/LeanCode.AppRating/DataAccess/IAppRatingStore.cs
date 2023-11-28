using Microsoft.EntityFrameworkCore;

namespace LeanCode.AppRating.DataAccess;

public interface IAppRatingStore<TUserId>
    where TUserId : notnull, IEquatable<TUserId>
{
    public DbSet<AppRating<TUserId>> AppRatings { get; }
}
