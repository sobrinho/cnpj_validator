module ActiveRecord
  module Validations
    module ClassMethods
      def validates_as_cnpj *attr_names
        configuration = { :message => :invalid }
        configuration.update(attr_names.extract_options!)

        validates_each(attr_names, configuration) do |record, attr_name, value|
          unless CNPJ::valid? value
            record.errors.add attr_name, configuration[:message]
          end
        end
      end
    end
  end
end
