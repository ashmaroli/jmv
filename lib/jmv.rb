# frozen_string_literal: true

require_relative 'jmv/version'

require 'json'
require 'liquid'
require 'webrick'

module JMV
  class Servlet < WEBrick::HTTPServlet::AbstractServlet
    TEMPLATE_PATH = File.join(__dir__, 'jmv', 'template.html.liquid').freeze
    private_constant :TEMPLATE_PATH

    def do_GET(_request, response)
      metadata_file = @server.config[:ResourcePath]
      metadata = read metadata_file

      context = {
        'app'  => {
          'name'    => 'Jekyll Metadata file Viewer',
          'version' => JMV::VERSION,
        },
        'data' => {
          'path' => metadata_file,
          'data' => metadata,
          'json' => JSON.pretty_generate(metadata),
        }
      }

      # Repeat on every browser window refresh
      template_contents = File.binread(TEMPLATE_PATH)
      rendered_contents = Liquid::Template.parse(template_contents).render(context)

      response.status = 200
      response['Content-Type'] = 'text/html'
      response.body = rendered_contents
    end

    private

    def read(file)
      Marshal.load(File.binread(file))
    rescue StandardError => e
      puts "  Error loading #{file}: #{e}"
      raise e
    end
  end

  def self.start(options)
    source = File.expand_path(options[:source] || '')
    puts "\n         Source: #{source}"
    metadata_file = File.join(source, '.jekyll-metadata') 

    if File.exist?(metadata_file) && !File.directory?(metadata_file)
      puts "  Metadata file: #{metadata_file}"
      puts ''
      puts '  Processing..'
    else
      puts "  Error: Could not find the '.jekyll-metadata' file at source. Aborting.."
      puts '         Build or serve a Jekyll source either with `--incremental` CLI option or'
      puts '         with `incremental: true` config setting to generate the metadata file.'
      return
    end

    server = WEBrick::HTTPServer.new(
      :Port         => options[:port] || 3000,
      :Logger       => WEBrick::Log.new($stdout, WEBrick::Log::WARN),
      :AccessLog    => [],
      :ResourcePath => metadata_file
    )
    server.mount('/', Servlet)
    trap('INT') do
      puts '  Shutting down server..'
      puts ''
      server.shutdown
    end
    puts '  Starting server..'
    puts "  Server mounted at http://localhost:#{server.config[:Port]}."
    puts ''
    server.start
  end
end
