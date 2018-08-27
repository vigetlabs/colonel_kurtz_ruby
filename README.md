# ColonelKurtzRuby

Ruby wrapper for Colonel Kurtz data.

[![Code Climate](https://codeclimate.com/github/vigetlabs/colonel_kurtz_ruby/badges/gpa.svg)](https://codeclimate.com/github/vigetlabs/colonel_kurtz_ruby) [![Test Coverage](https://codeclimate.com/github/vigetlabs/colonel_kurtz_ruby/badges/coverage.svg)](https://codeclimate.com/github/vigetlabs/colonel_kurtz_ruby/coverage)

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

block.parent
#=> nil

block.children
#=> [
#  <ColonelKurtz::Block:0x007fb0eb7bf950....>
#]

block.children[0].parent
#=> <ColonelKurtz::Block:0x047ae78820c3c0b24...>
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

#### JSONB Datatype

If your database supports it and you're using ActiveRecord, you can also
serialize the data as the JSONB data type, and deserialize it as a string so it
can be put into `hidden_input` inputs and updated by ColonelKurtz in forms.

```ruby
class BlockableExample < ApplicationRecord
  serialize :data, ColonelKurtz::ActiveRecord::Serializer
end
```

#### Why would you want to store as JSONB?

This allows you to construct queries to introspect on the CK data.

Here's an example. Let's say you have a CK block that represents a chosen photo
from your system, and the output JSON of that block looks like this:

```json
{
  "type"    : "example-photo-block",
  "content" : { "id" : 1 },
  "blocks"  : []
}
```

Let's also say you have a model called `Page` with CK data that contains the
above block (`Photo` with ID `1`). Wouldn't it be nice to know which pages
depend on this photo? If the CK data is serialized as JSON, we can find them!

```ruby
class Photo
  #...

  def embedded_in_pages
    @embedded_in_pages ||=
      Page.joins("JOIN LATERAL jsonb_array_elements(data) block ON block -> 'content' -> 'id' = #{id}")
          .where("block ->> 'type' IN ('example-photo-block')")
          .distinct
  end
end
```

Big wins! :tada:

#### What if I'm already storing the blocks as text?

If you're currently storing CK content as text, you can update the content to
be JSONB with this example migration. `Page` is an example ActiveRecord with a
column `content` that represents the ColonelKurtz data.

```ruby
class ChangePageContentToJson < ActiveRecord::Migration[5.2]
  def up
    change_column :pages, :content, 'jsonb USING CAST(content AS jsonb)', default: '[]'
    execute "CREATE INDEX pages_content_gin ON pages USING gin (content jsonb_path_ops);"
  end

  def down
    execute "DROP INDEX pages_content_gin"
    change_column :pages, :content, 'text USING CAST(content AS text)'
  end
end

## When creating new tables

class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      # ...

      t.jsonb :content, null: false, default: []

      # ...
    end
  end
end
```

[Read more about JSON indexes in
Postgres.](https://www.postgresql.org/docs/current/static/gin-intro.html)

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

***

<a href="http://code.viget.com">
  <img src="http://code.viget.com/github-banner.png" alt="Code At Viget">
</a>

Visit [code.viget.com](http://code.viget.com) to see more projects from [Viget.](https://viget.com)
