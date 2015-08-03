require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    q_marks = params.map{|key, _| "#{key} = ?"}.join(" AND ")
    results = DBConnection.execute(<<-SQL, *params.values)
      SELECT *
      FROM #{table_name}
      WHERE #{q_marks}
    SQL

     parse_all(results)
  end
end

class SQLObject
  extend Searchable
end
