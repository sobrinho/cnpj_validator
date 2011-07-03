require 'rubygems'
require 'test/unit'
require 'active_model'
require 'cnpj_validator'
require 'ostruct'

class Company < OpenStruct
  include ActiveModel::Validations
  validates :cnpj, :cnpj => true
end
