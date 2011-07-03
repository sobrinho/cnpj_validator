class CnpjValidator::Cnpj
  def self.valid?(number)
    new(number).valid?
  end

  attr_reader :number

  def initialize(number)
    @number = number
  end

  def digits
    @digits ||= number.scan(/\d/).map(&:to_i)
  end

  def plain
    @plain ||= digits.join
  end

  def valid?
    formatted? && !black_listed? && digits_matches?
  end

  private

  def formatted?
    plain =~ /^\d{14}|\d{2}\.\d{3}\.\d{3}\/\d{4}-\d{2}$/
  end

  def black_listed?
    plain =~ /^(\d)\1{13}$/
  end

  def digits_matches?
    digit_matches?(12) && digit_matches?(13)
  end

  def digit_matches?(digit)
    factor = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
    factor.unshift 6 if digit == 13

    sum = 0

    digit.times do |i|
      sum += digits[i] * factor[i]
    end

    result = sum % 11
    result = result < 2 ? 0 : 11 - result

    result == digits[digit]
  end
end
