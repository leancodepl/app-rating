using LeanCode.Contracts;
using LeanCode.Contracts.Security;

namespace LeanCode.AppRating.Contracts;

[AuthorizeWhenHasAnyOf(RatingPermissions.RateApp)]
public class RatingAlreadySent : IQuery<bool> { }
