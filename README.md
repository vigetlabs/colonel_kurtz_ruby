# ColonelKurtzRuby

Ruby wrapper for Colonel Kurtz data.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'colonel_kurtz_ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install colonel_kurtz_ruby

## Usage

Colonel Kurtz Ruby is a lightweight shim between the JSON data that Colonel Kurtz (https://github.com/vigetlabs/colonel-kurtz) creates and POROs.

#### Example

for Colonel Kurtz `data`:

```JSON
{
  "type"    : "example-block",
  "content" : { "html" : "<p>Example</p>" },
  "blocks"  : [
    {
      "type"    : "example-block",
      "content" : { "html" : "<p>Text</p>" },
      "blocks"  : []
    }
  ]
}
```

```ruby
block = ColonelKurtz::Block.new(data)

block.type
#=> :example_block

block.contents
#=> { "html" => "<p>Example</p>" }

block.children
#=> [
  #<ColonelKurtz::Block:0x007fb0eb7bf950....>
]
```

#### Model

Colonel Kurtz Ruby also includes a model mixin for exposing fields that contain Colonel Kurtz data.

```ruby
class BlockableExample
  extend ColonelKurtz::Model::Blockable

  has_blocks :content

  attr_reader :data

  def initialize(data)
    @data = data
  end

  def content
    JSON.generate([data])
  end
end
```

```ruby
example = BlockExample.new(data)

example.content_blocks
#=> [
  #<ColonelKurtz::Block:0x007fb0eb7bf950....
  ...
]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/colonel_kurtz_ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

Viget (www.viget.com)
