class CnpjValidator < ActiveModel::EachValidator
  autoload :Cnpj, 'cnpj_validator/cnpj'

  def validate_each(record, attribute, value)
    record.errors.add(attribute, options[:message]) if Cnpj.invalid?(value)
  end
end
