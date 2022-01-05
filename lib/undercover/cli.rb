# frozen_string_literal: true

require 'fileutils'

module DangerUndercover
  # module for undercover-report
  module CLI
    class << self
      # Runs the undercover command with provided arguments
      # and writes the output to a file
      # @return  [String]
      #
      def run(args = nil)
        undercover_output = `undercover #{args&.join(' ')}`

        File.write(output_file, undercover_output)

        undercover_output
      end

      private

      # Returns the file to write report to
      # @return  [String]
      #
      def output_file
        create_directory!

        File.join(output_directory, 'undercover.txt')
      end

      # Creates directory if doesn't exists
      # @return  [String]
      #
      def create_directory!
        return if Dir.exist?(output_directory)

        FileUtils.mkdir_p(output_directory)
      end

      # Output directory
      # @return  [String]
      #
      def output_directory
        File.join(Dir.getwd, 'coverage')
      end
    end
  end
end
