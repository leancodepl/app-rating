namespace LeanCode.AppRating.EmailViewModels;

public class LowRateSubmittedEmail
{
    public double Rating { get; set; }
    public string? UserId { get; set; }
    public string? AdditionalComment { get; set; }
}
