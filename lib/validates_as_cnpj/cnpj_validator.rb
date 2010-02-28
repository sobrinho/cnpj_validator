class CnpjValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, options[:message]) if CNPJ.invalid?(value)
  end
end
