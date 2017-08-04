# Keyline

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/keyline`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'keyline', github: 'crispymtn/keyline-gem'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install keyline

## Usage

Now that you have the Keyline gem installed, you can use it to connect to your Keyline account. First you need to setup your API Key, this can be done explicitly or implicitly, by setting the ENV variable KEYLINE_API_TOKEN or by adding keyline_api_token to Rails' secrets.yml file in the config dir.

```ruby
# Explicitly set an API token
Keyline.client.api_key = 'YOUR API KEY GOES HERE'
```

And let's create an order with a product that has a component. Also the product will have a finishing with some params we need to adjust.

```ruby
# Create the order
order = Keyline.orders.create(customer_id: 1337)

# Add a empty product
product = order.products.create(name: 'New product', category: 'book')

# Add a component to the product
product.components.create(name: 'Contents', closed_dimensions: [297, 210], front_colors: ['CMYK/Black'], back_colors: ['CMYK/Black, Pantone/501'])

# Lets add a finishing to the product (also possible with components)
finishing = product.finishings.create(stock_finishing_id: 12)

# And change the property's value
finishing.finishing_properties.select { |fp| fp.key == 'beidseitig' }.first.update_attributes(value: true)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/keyline. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Keyline project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/keyline/blob/master/CODE_OF_CONDUCT.md).
