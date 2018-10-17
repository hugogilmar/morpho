# Morpho
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'morpho'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install morpho
```

## Validators

### Contain number validator

Value must contain at least 1 number.

options:
  * **message**: A custom message. Defaults to `I18n.t('morpho.labels.validators.contain_number')`

```ruby
class User < ApplicationRecord
  validates :password, :'morpho/validators/contain_number' => true
end
```

### Contain uppercase validator
Value must contain at least 1 uppercase letter.

options:
  * **message**: A custom message. Defaults to `I18n.t('morpho.labels.validators.contain_uppercase')`

```ruby
class User < ApplicationRecord
  validates :password, :'morpho/validators/contain_uppercase' => true
end
```

### Contain symbol validator
Value must contain at least 1 special char.

options:
  * **message**: A custom message. Defaults to `I18n.t('morpho.labels.validators.contain_symbol')`
  
```ruby
class User < ApplicationRecord
  validates :password, :'morpho/validators/contain_symbol' => true
end
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
