require 'csv'

module BankScrap
  module Exporter
    class Csv
      HEADERS = %w(ID Date Category Subcategory Description DescriptionDetail Amount).freeze

      def initialize(output = nil)
        @output = output || 'transactions.csv'
      end

      def write_to_file(data)
        CSV.open(@output, 'wb') do |csv|
          csv << HEADERS
          data.each { |line| csv << line.to_a }
        end
      end
    end
  end
end
