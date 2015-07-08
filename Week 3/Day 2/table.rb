require_relative 'q_db'

class Table

  def self.find_by_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT * FROM #{self.tab_name} WHERE id = ?
    SQL

    self.class.convert(results).first
  end

  def self.convert(results)
    items = []
    results.each do |item|
      items << self.class.new(item)
    end

    items
  end

  def save_thing
    vars = self.instance_variables.drop(1).map {|var| var.to_s.delete('@')}
    params = vars.map {|var| self.send(var.to_sym)}

    @id.nil? ? inserter(vars, params) : updater(vars, params)
  end

  #TODO implement where
  # Reply.where(author_id: 2, parent_id: 1)

  def self.where(hash = {})
    attributes = hash.keys
    values = hash.values
    accu = []
    hash.each do |attr, value|
      accu << "#{attr.to_s} = '#{value.to_s}'"
    end
    accu = accu.join(" AND ")
    QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        #{tab_name}
      WHERE
        #{accu}
    SQL
  end

  def inserter(vars, params)
    vars = vars.join(", ")
    catcher = Array.new(params.size) { '?' }.join(', ')

    QuestionsDatabase.instance.execute(<<-SQL, *params)
      INSERT INTO
        #{tab_name} (#{vars})
      VALUES
        (#{catcher})
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def updater(vars, params)
    catcher = params.map.with_index { |_, i| vars[i] + "=?, " }.join('')[0..-3]
    QuestionsDatabase.instance.execute(<<-SQL, *params, @id)
      UPDATE #{tab_name}
      SET #{catcher}
      WHERE id = ?
    SQL
  end

end
