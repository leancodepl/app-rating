using System.Collections.Immutable;
using System.Text.Json;
using LeanCode.DomainModels.EF;
using Microsoft.EntityFrameworkCore;

namespace LeanCode.AppRating.DataAccess;

public static class ModelBuilderExtensions
{
    public static void ConfigureAppRatingEntity<TUserId>(this ModelBuilder builder, SqlDbType sqlDbType)
        where TUserId : notnull, IEquatable<TUserId>
    {
        builder.Entity<AppRating<TUserId>>(c =>
        {
            c.HasKey(e => e.Id);
            c.Property(e => e.Id).HasConversion<RawTypedIdConverter<Guid, AppRatingId>>();

            c.HasIndex(e => new { e.UserId, e.DateCreated });

            c.Property(e => e.UserId).ValueGeneratedNever();

            switch (sqlDbType)
            {
                case SqlDbType.PostgreSql:
                    c.Property(e => e.Metadata).HasColumnType("jsonb");
                    break;
                case SqlDbType.MsSql:
                    c.Property(e => e.Metadata)
                        .HasConversion(
                            a => JsonSerializer.Serialize(a, (JsonSerializerOptions?)null),
                            j =>
                                JsonSerializer.Deserialize<ImmutableDictionary<string, object>>(
                                    j,
                                    (JsonSerializerOptions?)null
                                )
                        )
                        .HasMaxLength(4000);
                    c.Property(e => e.Metadata).HasMaxLength(4000);
                    c.Property(e => e.AdditionalComment).HasMaxLength(4000);
                    c.Property(e => e.SystemVersion).HasMaxLength(200);
                    c.Property(e => e.AppVersion).HasMaxLength(200);
                    break;
            }
        });
    }
}

public enum SqlDbType
{
    PostgreSql = 0,
    MsSql = 1,
}
