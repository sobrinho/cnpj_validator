class CnpjValidator::Cnpj
  BLACK_LIST = %w(00000000000000 11111111111111 22222222222222 33333333333333
                  44444444444444 55555555555555 66666666666666 77777777777777
                  88888888888888 99999999999999)

  def self.valid?(cnpj)
    cnpj = cnpj.to_s

    # could be 13 or 14 digits or with mask 99.999.999/9999-99
    if cnpj !~ /^\d{13,14}|\d{2}\.\d{3}\.\d{3}\/\d{4}-\d{2}$/
      return false
    end

    cnpj = cnpj.scan(/\d/).collect(&:to_i)
    cnpj.unshift(0) if cnpj.length == 13

    # filter black list
    if BLACK_LIST.include? cnpj.join
      return false
    end

    # calculate first digit
    factor = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]

    sum = (0..11).inject(0) do |sum, i|
      sum + cnpj[i] * factor[i]
    end

    result = sum % 11
    result = result < 2 ? 0 : 11 - result

    if result != cnpj[12]
      return false
    end

    # calculate second digit
    factor.unshift 6

    sum = (0..12).inject(0) do |sum, i|
      sum + cnpj[i] * factor[i]
    end

    result = sum % 11
    result = result < 2 ? 0 : 11 - result

    result == cnpj[13]
  end

  def self.invalid?(cnpj)
    !valid?(cnpj)
  end
end
