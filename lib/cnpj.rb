module CNPJ
  # Invalids
  INVALIDS = %w(
    00000000000000 11111111111111 22222222222222 33333333333333
    44444444444444 55555555555555 66666666666666 77777777777777
    88888888888888 99999999999999)

  def self.valid? cnpj
    # Basic validation
    cnpj = cnpj.to_s

    if cnpj !~ /^\d{14}|\d{2}\.\d{3}\.\d{3}\/\d{4}-\d{2}$/
      return false
    end

    cnpj = cnpj.scan(/\d/).collect(&:to_i)

    if INVALIDS.member? cnpj.to_s
      return false
    end

    # Parse first digit
    factor = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]

    sum = (0..11).inject(0) do |sum, i|
      sum + (cnpj[i] * factor[i])
    end

    result = sum % 11
    result = result < 2 ? 0 : 11 - result

    return false unless cnpj[12] == result

    # Parse second digit
    factor.unshift 6

    sum = (0..12).inject(0) do |sum, i|
      sum + (cnpj[i] * factor[i])
    end

    result = sum % 11
    result = result < 2 ? 0 : 11 - result

    return result == cnpj[13]
  end
end
