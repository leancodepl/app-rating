using Microsoft.AspNetCore.Http;

namespace LeanCode.AppRating;

public interface IUserIdExtractor<TUserId>
{
    public bool TryExtract(HttpContext httpContext, out TUserId? userId);
    public TUserId Extract(HttpContext httpContext)
    {
        if (!TryExtract(httpContext, out var userId))
        {
            throw new InvalidOperationException("UserId could not be extracted.");
        }
        return userId!;
    }
}
