require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options
  #has_one :home, through: owner, source: home
  #make cat.home == cat.owner.home
#   def has_one_through(name, through_name, source_name)
	

#   	define_method(name) do
#   		send(through_name).send(source_name)
#   	end
#   end
# end
	
	def has_one_through(name, through_name, source_name)
		
		
		through_options = self.assoc_options[through_name]

		define_method(name) do
			sfk = through_options.model_class.assoc_options[source_name].foreign_key
			spk = through_options.model_class.assoc_options[source_name].primary_key
			stbl = through_options.model_class.assoc_options[source_name].table_name
			tfk = through_options.foreign_key
			tpk = through_options.primary_key
			tfkval = self.send(through_options.foreign_key)
			ttbl = through_options.table_name
			vals = DBConnection.execute(<<-SQL)
				SELECT
					#{stbl}.*
				FROM
					#{stbl}
				JOIN
					#{ttbl}
				ON
					#{ttbl}.#{sfk} = #{stbl}.#{spk}
				WHERE
					#{ttbl}.#{tpk} = #{tfkval}
			SQL
			puts vals
			puts through_options.model_class
			through_options.model_class.assoc_options[source_name].model_class.new(vals.first)
		end
	end
end