class CreateMyView < ActiveRecord::Migration
  extend SqlMigration

  def self.up
    sql_up
  end

  def self.down
    sql_down
  end
end
