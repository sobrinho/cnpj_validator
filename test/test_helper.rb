require 'rubygems'
require 'test/unit'
require 'active_support'
require 'active_record'
require 'validates_as_cnpj/cnpj_validator'
require 'validates_as_cnpj/cnpj'

# create a temporary database
ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database => ':memory:'

silence_stream(STDOUT) do
  ActiveRecord::Schema.define do
    create_table :companies do |t|
      t.string :name
      t.string :document
    end
  end
end
