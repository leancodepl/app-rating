using LeanCode.AppRating.Handlers;
using MassTransit;

namespace LeanCode.AppRating;

public static class MassTransitRegistrationConfigurationExtensions
{
    public static void AddAppRatingConsumers<TUserId>(this IRegistrationConfigurator configurator)
        where TUserId : notnull, IEquatable<TUserId>
    {
        configurator.AddConsumer(
            typeof(SendEmailOnLowRateSubmittedEH<TUserId>),
            typeof(AppRatingConsumerDefinition<SendEmailOnLowRateSubmittedEH<TUserId>>)
        );
    }
}

public class AppRatingConsumerDefinition<TConsumer> : ConsumerDefinition<TConsumer>
    where TConsumer : class, IConsumer
{
    protected override void ConfigureConsumer(
        IReceiveEndpointConfigurator endpointConfigurator,
        IConsumerConfigurator<TConsumer> consumerConfigurator,
        IRegistrationContext context
    )
    {
        endpointConfigurator.UseMessageRetry(
            r => r.Immediate(1).Incremental(3, TimeSpan.FromSeconds(5), TimeSpan.FromSeconds(5))
        );
    }
}
