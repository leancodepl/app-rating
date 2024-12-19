# app_rating

<img width="300" alt="image" src="https://github.com/user-attachments/assets/f5d48083-7f18-4a1d-9a5d-82d3f862f3cd">
<img width="300" alt="image" src="https://github.com/user-attachments/assets/0ba3321e-39fb-4f9b-94ee-6e7cbca1fe98">
<img width="300" alt="image" src="https://github.com/user-attachments/assets/b7d40e4e-cf22-4199-9240-2f690357e5f5">

## Description

This feature provides out-of-the-box support for collecting direct feedback from users. Feedback can be gathered through two methods:

- **Five star rating with optional comment:** Users can provide a rating on a 1-5 star scale, accompanied by an optional comment.
- **Yes/No Satisfaction:** Users can answer a simple yes/no question regarding their overall satisfaction with the application.

If the user provides a positive review, they will be kindly asked to rate the application on the app store. In addition to the feedback, OS and mobile device parameters are automatically stored in the backend for analytics purposes.

## Usage

### Mobile

#### Setup

Add `AppRatingLocalizations` to your localizations delegates in `MaterialApp`:
```dart
  localizationsDelegates: const [
    (...)
    ...AppRatingLocalizations.localizationsDelegates,
  ],
```

Initialize `AppRating` instance with:
- your `cqrs`
- your app's AppStore ID (ex. `apps.apple.com/us/app/example/id000000000`)
- app version tag (`CFBundleShortVersionString` on iOS, `versionName` on Android). Feel free to use the [package_info_plus](https://pub.dev/packages/package_info_plus) for getting this value.

```dart
final rateApp = AppRating(
  cqrs: cqrs,
  appleStoreId: '111111',
  appVersion: packageInfo.version,
);
```

then provide it globally with `Provider` and use wherever you want to.

#### Yes/No dialog

```dart
void showSingleAnswerDialog(
  BuildContext context, {
  String? singleAnswerDialogHeader,
  String? singleAnswerDialogPositiveButton,
  String? singleAnswerDialogNegativeButton,
  String? singleAnswerDialogCancelButton,
  String? singleAnswerDialogMoreInfoHeader,
  String? singleAnswerDialogMoreInfoPrimaryButton,
  String? singleAnswerDialogMoreInfoSecondaryButton,
})
```

A dialog box is displayed, presenting the user with a `Yes` or `No` option to answer whether they like the application. The user's response is mapped as follows:
- Selecting `Yes` sends a value of 5 to the backend.
- Selecting `No` sends a value of 0 to the backend.

Upon selecting Yes, the `requestReview` function from the [in_app_review](https://pub.dev/packages/in_app_review) package is invoked in the background. This function attempts to display the app review dialog from the app store.

**WARNING:** The review dialog is not guaranteed to appear, as its display is controlled by the OS.

#### Five star rating dialog

```dart
void showStarDialog(
  BuildContext context, {
  String? starDialogHeader,
  String? starDialogSubtitle,
  String? starDialogPrimaryButton,
  String? starDialogSecondaryButton,
  String? starDialogRateUsHeader,
  String? starDialogRateUsSubtitle,
  String? starDialogOpenStoreButton,
  String? starDialogOpenStoreCloseButton,
})
```

The showStarDialog function displays a dialog box allowing the user to provide a star rating. If the user rates the app with fewer than 5 stars, the dialog expands to include a text field for additional comments. For high ratings (5 stars), the dialog changes its appearance by showing a button that directs the user to the app store to submit a review.

#### Customization

In the current version of this package, you're not able to have a strong impact on how the dialogs look and how the flow works. You can apply your own texts and labels into `showStarDialog` and `showSingleAnswerDialog` methods. But at this moment, that's it.

## Backend

The backend is responsible for storing the feedback data and sending it to the analytics system. The feedback data includes the following parameters:
- `Rating` (double): The user's rating on a scale defined by mobile app.
- `AdditionalComment` (string): The user's optional comment.
- `Platform` (PlatformDTO): Android or iOS.
- `SystemVersion` (string): The user's operating system version.
- `AppVersion` (string): The user's application version.
- `Metadata` (Dictionary<string, object>): Additional metadata containing any other data important (tenant information, feature flag configuration, etc.).

### Setup

Reference `LeanCode.AppRating.Contracts` in your contracts project.

```
  <ItemGroup>
    (...)
    <PackageReference Include="LeanCode.AppRating.Contracts" />
    (...)
  </ItemGroup>
```
Reference `LeanCode.AppRating` in your service.

```
  <ItemGroup>
    (...)
    <PackageReference Include="LeanCode.AppRating" />
    (...)
  </ItemGroup>
```

Configure `YourDbContext` so that it implements `IAppRatingStore<TUserId>` interface.

```csharp
public class YourDbContext : DbContext, IAppRatingStore<TUserId>
{
    (...)

    public DbSet<AppRating<TUserId>> AppRatings => Set<AppRating<TUserId>>();

    (...)

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        (...)

        builder.ConfigureAppRatingEntity<TUserId>(SqlDbType.PostgreSql);

        (...)
    }
}
```

Register AppRating module in your `Startup` class - you need to define:
- `TUserId` - type of user id (Can be `Guid`, `int`, `string`, or [strongly typed id](https://leancode-corelibrary.readthedocs.io/domain/id/)).
- `TUserIdExtractor` - class that implements `IUserIdExtractor<TUserId>` interface. It is responsible for extracting user id from the request.
- `YourDbContext` - db context where feedback will be stored. Remember to point DbContext configured in previous step.

```csharp
public class Startup : LeanStartup
{
    (...)

    public void ConfigureServices(IServiceCollection services)
    {
        services
            (...)
            .AddAppRating<TUserId, YourDbContext, TUserIdExtractor>()
            (...);
    }

    (...)
}

public sealed class TUserIdExtractor : IUserIdExtractor<TUserId>
{
    public TUserId Extract(HttpContext httpContext)
    {
        // implement your own logic to extract user id, eg. from claims

        var claim = context.User.FindFirstValue(Auth.KnownClaims.UserId);

        ArgumentException.ThrowIfNullOrEmpty(claim);

        return TUserId.Parse(claim);
    }
}
```

Configure user role to have `RateApp` permission, e.g.:

```csharp
internal class AppRoles : IRoleRegistration
{
    public IEnumerable<Role> Roles { get; } =
        [
            new Role(R.User, R.User, LeanCode.AppRating.Contracts.RatingPermissions.RateApp),
        ];
}
```

### Email configuration

You need to configure `AppRatingReportsConfiguration` in order to define administrative email details. We assume that you have already configured email sending and localization in your application. Ensure that `LowRatingEmailSubjectKey` is defined in your localization files.

```csharp
    public void ConfigureServices(IServiceCollection services)
    {
        (...)

        services.AddSingleton(
            new AppRatingReportsConfiguration(
                LowRatingUpperBoundInclusive: 2.0,
                LowRatingEmailCulture: "en",
                LowRatingEmailSubjectKey: "emails.low-rate-submitted.subject",
                FromEmail: "test+from@leancode.pl",
                ToEmails: ["test+to@leancode.pl", "support@example.app"]
            )
        );

        (...)
    }
```

You need to configure email templates for low rating reports named `LowRateSubmittedEmail`. You can use those templates as a starting point:

```html
<h4>One of your users send a low rate. Please log in to your admin panel to check details</h4>

<ul>
    <li>
        UserId: @{
            WriteLiteral(Model.UserId);
        }
    </li>

    <li>
        Rating: @{
            WriteLiteral(Model.Rating.ToString("F1"));
        }
    </li>

    <li>
        AdditionalComment: @{
            WriteLiteral(Model.AdditionalComment);
        }
    </li>
</ul>
```

```csharp
One of your users send a low rate. Please log in to your admin panel to check details

UserId: @{
    WriteLiteral(Model.UserId);
}

Rating: @{
    WriteLiteral(Model.Rating);
}

AdditionalComment: @{
    WriteLiteral(Model.AdditionalComment);
}
```

You need to configure MassTransit consumer that will send emails.

```csharp
    public override void ConfigureServices(IServiceCollection services)
    {
        (...)

        services.AddCQRSMassTransitIntegration(cfg =>
        {
            (...)

            cfg.AddAppRatingConsumers<TUserId>();

            (...)
        });

        (...)
    }
```

## Requirements
**Note:** Debugging this on the emulators or the simulators will not provide the faithful experience of production environment.

### Android
- Android 5 or higher
- Google Play Store must be installed.

### iOS
Requires iOS version 10.3

## Guidelines

While the `AppRating` instance shares the `in_app_review` interface with the `requestReview()` method, it is not recommended to use this method directly. App store guidelines are typically strict regarding when and how users are asked to leave the reviews. Also offering in-app rewards for the reviews is often prohibited.

If you want to implement a "Give us feedback" action button, use one of the following methods:
- `appRating.showStarDialog()`
- `appRating.showSimpleAnswerDialog()`
- `appRating.inAppReview.openStoreListing()` (for a more direct approach, but use with caution).

If you choose to use the `appRating.inAppReview.requestReview()` method, ensure it is integrated into the app’s logic in a way that avoids triggering it too early or too frequently, to comply with store guidelines.

Check out these official guidelines:
- https://developer.apple.com/design/human-interface-guidelines/ios/system-capabilities/ratings-and-reviews/
- https://developer.android.com/guide/playcore/in-app-review#when-to-request
- https://developer.android.com/guide/playcore/in-app-review#design-guidelines

## Team
- @lukaszgarstecki
- @denis-lncd
