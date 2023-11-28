namespace LeanCode.AppRating.EmailViewModels;

public class LowRateSubmittedEmail
{
    public double Rating { get; set; }
    public string UserId { get; set; } = null!;
    public string? AdditionalComment { get; set; }
}
