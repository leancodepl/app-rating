using LeanCode.AppRating.DataAccess;
using Microsoft.EntityFrameworkCore;

namespace LeanCode.AppRating.IntegrationTests.App;

public class TestDbContext : DbContext, IAppRatingStore<Guid>
{
    private readonly TestDatabaseConfig config;

    public TestDbContext(DbContextOptions<TestDbContext> options)
        : base(options)
    {
        config = TestDatabaseConfig.Create();
    }

    public DbSet<AppRatingEntity<Guid>> AppRatings => Set<AppRatingEntity<Guid>>();

    protected override void OnModelCreating(ModelBuilder builder)
    {
        base.OnModelCreating(builder);
        builder.ConfigureAppRatingEntity<Guid>(config.DbType);
    }
}
