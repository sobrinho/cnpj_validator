require 'test_helper'

class CnpjValidatorTest < Test::Unit::TestCase
  def test_black_list
    %w(00000000000000 11111111111111 22222222222222 33333333333333
       44444444444444 55555555555555 66666666666666 77777777777777
       88888888888888 99999999999999).each do |number|
      assert_invalid number
    end
  end

  def test_invalid
    assert_invalid '50.108.399/7175-07'
    assert_invalid '77.017.159/3095-80'
    assert_invalid '03.971.701/5859-70'
  end

  def test_masked
    assert_valid '38.417.923/0001-16'
    assert_valid '43.010.889/0001-09'
    assert_valid '85.113.468/0001-45'
  end

  def test_unmasked
    assert_valid '38417923000116'
    assert_valid '43010889000109'
    assert_valid '85113468000145'
  end

  protected

  def assert_valid(cnpj)
    assert company(:cnpj => cnpj).valid?
  end

  def assert_invalid(cnpj)
    assert company(:cnpj => cnpj).invalid?
  end

  def company(attributes = {})
    Company.new(attributes)
  end
end
