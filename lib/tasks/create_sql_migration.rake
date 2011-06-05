require 'db/sql_migration'

namespace :db do

  task :create_sql_migration, :name do |t,args|
    MigrationCreator.new(args[:name], true) do |m|
      m.create_migration_file
      m.create_sql_files
    end
  end

end

class MigrationCreator

  def initialize(name, is_sql=false)
    @is_sql = is_sql
    @basename = "#{Time.now.strftime("%Y%m%d%H%M%S")}_#{name}"
    @class_name = name.split('_').collect { |word| word.capitalize }.join
    @migration_file = "db/migrate/#{@basename}.rb"
    @sql_down_file = "db/migrate/sql/#{@basename}_down.sql"
    @sql_up_file = "db/migrate/sql/#{@basename}_up.sql"
    yield self if block_given?
  end

  def sql?
    @is_sql
  end

  def create_migration_file
    f = File.new(@migration_file, 'w+')
    f.puts "class #{@class_name} < ActiveRecord::Migration"
    f.puts '  extend SqlMigration' if sql?
    f.puts
    f.puts '  def self.up'
    f.puts '    sql_up' if sql?
    f.puts '  end'
    f.puts
    f.puts '  def self.down'
    f.puts '    sql_down' if sql?
    f.puts '  end'
    f.puts 'end'
  end

  def create_sql_files
    File.new(@sql_down_file, 'w+')
    File.new(@sql_up_file, 'w+')
  end

end
