require 'test_helper'

class ValidatesAsCnpjTest < ActiveSupport::TestCase
  class Company < ActiveRecord::Base
    validates :document, :cnpj => true
  end
  
  test "blank values" do
    assert_equal false, Company.new(:document => '').valid?
    assert_equal false, Company.new(:document => false).valid?
    assert_equal false, Company.new(:document => nil).valid?
  end
  
  test "black list" do
    CNPJ::BLACK_LIST.each do |cnpj|
      assert_equal false, Company.new(:document => cnpj).valid?
    end
  end
  
  test "only digits" do
    assert Company.new(:document => '41821571000174').valid?
  end
  
  test "with mask" do
    assert Company.new(:document => '41.821.571/0001-74').valid?
  end
  
  test "integer value" do
    assert Company.new(:document => 41821571000174).valid?
  end
  
  test "integer value missing 0" do
    assert Company.new(:document => 3133161000141).valid?
  end
end
