require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    cols = DBConnection.execute2(<<-SQL).first.map{|col| col.to_sym}
      SELECT *
      FROM #{table_name}
    SQL

    cols.each do |col|
      define_method("#{col}") { attributes[col] }
      define_method("#{col}=") { |val| attributes[col] = val }
    end
  end

  def self.finalize!
    self.columns
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || self.to_s.tableize
  end

  def self.all
    results = DBConnection.execute(<<-SQL)
      SELECT #{table_name}.*
      FROM #{table_name}
    SQL

    parse_all(results)
  end

  def self.parse_all(results)
    holder = []
    results.each do |values|
      puts values
      holder << self.new(values)
    end
    holder
  end

  def self.find(id)
    results = DBConnection.execute(<<-SQL, id)
      SELECT *
      FROM #{table_name}
      WHERE id = ?
    SQL
    parse_all(results).first
  end

  def initialize(params = {})
    params.each do |key, value|
      raise "unknown attribute '#{key}'" unless self.class.columns.include?(key.to_sym)
       send("#{key}=", value)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    @attributes.values
  end

  def insert
    q_marks = attributes.keys.map{'?'}.join(', ')
    cols = attributes.keys.join(', ')
    DBConnection.execute(<<-SQL, *attribute_values)
      INSERT INTO #{self.class.table_name}
        (#{cols})
      VALUES
        (#{q_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    setup = attributes.keys.drop(1).map {|col| "#{col} = ?" }.join(', ')
    DBConnection.execute(<<-SQL, *attribute_values.drop(1))
      UPDATE #{self.class.table_name}
      SET #{setup}
      WHERE id = #{attribute_values[0]}
    SQL
  end

  def save
    id.nil? ? insert : update
  end
end
