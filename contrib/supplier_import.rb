#!/usr/bin/env ruby

require "bundler/setup"
require "keyline"
require 'csv'


class SupplierImport

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
    puts "---------------------------------------------------------------------------------------------------"
    puts "Starting import of '#{@input_file}' intro printery '#{@printery.name}' on system #{@host}"
    puts "---------------------------------------------------------------------------------------------------"

    CSV.foreach(@input_file, col_sep: ';', headers: true) do |row|
      @parsed_rows += 1

      supplier_data = parse_supplier_data_from_row(row)
      contact_data  = parse_contact_data_from_row(row)

      supplier = create_supplier(supplier_data)
      create_contact(supplier, contact_data) if supplier.errors.empty?
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
  def parse_supplier_data_from_row(row)
    { name: row[5].try(:strip).try(:gsub, /\s{2,}/, ' ') }
  end

  def create_supplier(supplier_data)
    Keyline.suppliers.create(supplier_data).tap do |supplier|
      if supplier.errors.any?
        @errors << { row: @parsed_rows, data: supplier_data, error: supplier.errors }
      else
        puts "Created Supplier from row:#{@parsed_rows} with name:#{supplier.name}, id:#{supplier.id}"
      end
    end
  end

  def parse_contact_data_from_row(row)
    first_name = row[0].try(:strip)
    name       = row[1].try(:strip)
    phone      = row[2].try(:strip).try(:gsub, /[^\d]/, '').try(:gsub, /^0/, '+44')
    email      = row[3].try(:strip)

    { name: name,
      first_name: first_name,
      phone: phone,
      email: email,
    }
  end

  def create_contact(supplier, contact_data)
    Keyline::SupplierContact.new(contact_data, supplier).tap do |contact|
      contact.save
      if contact.errors.any?
        @errors << { row: @parsed_rows, data: contact_data, error: contact.errors }
      else
        puts "Created Contact from row:#{@parsed_rows} with name:#{contact.name}, id:#{contact.id}, supplier_id:#{supplier.id}"
      end
    end
  end
end

def help_message
  "
    supplier_import.rb <csv_input_file> <api_token> <api_host>

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

  SupplierImport.new(input_file: input_file, host: keyline_api_host, token: keyline_api_token)
    .perform_import!
    .report
end

