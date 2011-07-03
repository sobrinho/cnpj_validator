class CnpjValidator < ActiveModel::EachValidator
  autoload :Cnpj, 'cnpj_validator/cnpj'

  def validate_each(record, attribute, value)
    record.errors.add(attribute, options[:message]) unless Cnpj.valid?(value)
  end
end
