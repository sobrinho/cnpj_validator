# cnpj_validator

CNPJ validation for ActiveModel

## Installation

    gem "cnpj_validator"

## Usage

    class Company < ActiveRecord::Base
      validates :cnpj, :cnpj => true
    end

## License

Copyright (c) 2009-2012 nohup brasil, released under the MIT license
