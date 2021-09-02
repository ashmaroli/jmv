# JMV

Jekyll Metadata file Viewer (JMV) is a simple tool to enable viewing contents of the `.jekyll-metadata` file generated
by Jekyll when a site is built or served under _incremental_ mode.

## Installation

Add this line to your Jekyll site's Gemfile:

```ruby
gem 'jmv', '~> 0.1'
```

And then execute:

    $ bundle install

Or install it directly via:

    $ gem install jmv

## Usage

JMV installs as a command-line program that serves a local webpage generated and rendered using the contents of
the metadata file, provided that a `.jekyll-metadata` file exists at the root of the given directory.

1. `cd` into a Jekyll project directory containing the `.jekyll-metadata` file.

2. Run `jmv` or `bundle exec jmv` if the gem is to be used via a `Gemfile`.

The above two steps can be executed in a single step by utilizing the `--source` (or `-s`) option:

    $ jmv --source path/to/dir

Once the server is up and running, point your web browser to `http://localhost:3000` to view the metadata file contents.
If you wish to use a different port for the server, you may do so by utilizing the `--port` (or `-p`) option before
starting the server:

    $ jmv --port 8080

The server will then start mounted at `http://localhost:8080`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ashmaroli/jmv. This project is intended to be
a safe, welcoming space for collaboration, and contributors are expected to adhere to
the [code of conduct](https://github.com/ashmaroli/jmv/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the JMV project's codebases, issue trackers, chat rooms and mailing lists is expected to follow
the [code of conduct](https://github.com/ashmaroli/jmv/blob/master/CODE_OF_CONDUCT.md).
