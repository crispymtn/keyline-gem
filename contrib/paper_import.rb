#!/usr/bin/env ruby

require "bundler/setup"
require "keyline"
require 'csv'


class PaperImport

  def initialize(input_file:, host:, token:)
    Keyline.client(host: host, token: token)
    raise ArgumentError.new("Could not connect to Keyline!\n\n"+ help_message) unless Keyline.connection_valid?

    @host        = host
    @input_file  = input_file
    @printery    = Keyline.printery
    @errors      = []
    @parsed_rows = 0
  end

  def perform_import!
    puts "Starting import of '#{@input_file}' intro printery '#{@printery.name}' on system #{@host}"
    puts "---------------------------------------------------------------------------------------------------"

    CSV.foreach(@input_file, col_sep: ';', headers: true) do |row|
      @parsed_rows += 1
      paper_data = parse_data_from_row(row).reject { |c| c.blank? }
      create_paper(paper_data)
    end

    self
  rescue Keyline::Errors::ForbiddenError => e
    puts "INVALID API CREDENTIALS"
    raise e  # Can't recover from this, so just re-raise
  end

  def report
    puts "Import complete. Parsed #{@parsed_rows} rows, encountered #{@errors.size} errors."

    @errors.each do |error|
      puts "In row '%{row}' encountered error:\nParsed Data:%{data}\nException: %{error}" % error
    end
  end

private
  def create_paper(paper_data)
    Keyline.stock_papers.create(paper_data).tap do |paper|
      if paper.errors.any?
        @errors << { row: @parsed_rows, data: paper_data, error: paper.errors }
      else
        puts "Created StockPaper from row:#{@parsed_rows} with name:#{paper.name}, id:#{paper.id}, material_id:#{paper.material_id}"
      end
    end
  rescue Keyline::Error => e
    @errors << { row: @parsed_rows, data: paper_data, error: e }
  end

  def parse_data_from_row(row)
    name         = row[0].try(:strip).try(:gsub, /\s{2,}/, ' ').downcase.titleize
    color        = row[1]
    height       = row[2].try(:tr, ',', '.').try(:to_f)
    width        = row[3].try(:tr, ',', '.').try(:to_f)
    grammage     = row[4].try(:strip).try(:to_i)
    order_number = row[5].try(:strip)
    kind         = row[6]
    grain        = { 'BB' => 'short', 'SB' => 'long'}[row[7]] || row[7]
    thickness    = row[8] ? row[8].to_i : nil

    {
      name:                        name,
      color:                       color,
      dimensions:                  [width.to_i, height.to_i],
      grammage:                    grammage,
      supplier_identifiers:        [order_number],
      kind:                        kind,
      grain:                       grain,
      thickness:                   thickness
    }
  end
end

def help_message
  "
    paper_import.rb <csv_input_file> <api_token> <api_host>

                    Only <csv_input_file> is mandatory.
                    <api_token> and <api_host> can be specified in environment
                    as KEYLINE_API_TOKEN and KEYLINE_API_HOST respectively.
   "
end

if ARGV.size == 0
  puts help_message
else
  input_file            = ARGV[0]
  keyline_api_token     = ARGV[1] || ENV['KEYLINE_API_TOKEN']
  keyline_api_host      = ARGV[2] || ENV['KEYLINE_API_HOST'] || 'http://keyline.dev'

  PaperImport.new(input_file: input_file, host: keyline_api_host, token: keyline_api_token)
    .perform_import!
    .report
end

