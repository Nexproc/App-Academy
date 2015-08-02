require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    class_name.constantize
  end

  def table_name
    class_name == "Human" ? "humans" : class_name.tableize
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    self.foreign_key = options[:foreign_key] || "#{name}_id".to_sym
    self.class_name = options[:class_name] || name.to_s.capitalize
    self.primary_key = options[:primary_key] || "id".to_sym
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    self.foreign_key = options[:foreign_key] || (
        "#{self_class_name}_id".downcase.to_sym )

    self.class_name = options[:class_name] || (
        name.to_s.capitalize.singularize )
    self.primary_key = options[:primary_key] || "id".to_sym
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options)
    self.assoc_options[name] = options
    define_method(name) do
      fk = options.foreign_key
      pk = options.primary_key
      options.model_class.send(:where, { pk => attributes[fk] }).first
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, self, options)
    define_method(name) do
      fk = options.foreign_key
      pk = options.primary_key
      options.model_class.send(:where, { fk => attributes[pk] })
    end
  end

  def assoc_options
    @assoc_options ||= {}
  end
end

class SQLObject
  extend Associatable
end
