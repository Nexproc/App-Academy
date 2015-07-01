class Employee

  attr_accessor :boss
  attr_reader :salary, :employees

  def initialize(name, title, salary, boss = nil)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
    @employees = false
  end

  def bonus(multiplier)
    salary * multiplier
  end
end

class Manager < Employee

  def initialize(name, title, salary, boss = nil)
    super
    @employees = []
  end

  def hire(employee)
    employee.boss = self
    employees << employee
  end

  def gather_subordinate_salaries
    employees.inject(0) do |accum, employee|
      this = employee.salary
      this += employee.gather_subordinate_salaries if employee.is_a?(Manager)
      accum + this
    end
  end

  def bonus(multiplier)
    gather_subordinate_salaries * multiplier
  end

end
