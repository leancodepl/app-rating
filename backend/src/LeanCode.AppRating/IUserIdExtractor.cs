using Microsoft.AspNetCore.Http;

namespace LeanCode.AppRating;

public interface IUserIdExtractor<TUserId>
{
    public bool TryExtract(HttpContext httpContext, out TUserId? userId);
}
