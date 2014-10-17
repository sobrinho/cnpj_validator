class CnpjValidator < ActiveModel::EachValidator
  autoload :Cnpj, 'cnpj_validator/cnpj'

  def validate_each(record, attribute, value)
    message = options[:message].presence || :invalid
    record.errors.add(attribute, message) unless Cnpj.valid?(value)
  end
end
