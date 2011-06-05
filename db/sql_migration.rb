module SqlMigration
  def sql_up
    filename = File.basename(@migration_file, '.rb')
    sql = File.read("db/migrate/sql/#{filename}_up.sql")
    execute sql
  end

  def sql_down
    filename = File.basename(@migration_file, '.rb')
    sql = File.read("db/migrate/sql/#{filename}_down.sql")
    execute sql
  end

  def migration_file=(migration_file)
    @migration_file = migration_file
  end

  def self.extended(klass)
    klass.migration_file = File.basename(caller[0].split(':')[0], '.rb')
  end
end
