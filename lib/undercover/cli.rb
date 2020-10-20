# frozen_string_literal: true

require 'fileutils'
require 'optparse'
require 'pathname'

module DangerUndercover
  # module for undercover-report
  module CLI
    class << self
      DEFAULT_PATH = 'coverage/undercover.txt'
      attr_accessor :output_path

      # Runs the undercover command with provided arguments
      # and writes the output to a file
      # @return  [String]
      #
      def run(args = nil)

        parse_arguments!(args)
        set_default_path unless @output_path

        undercover_output = `undercover #{args&.join(' ')}`
        p output_path
        File.open(output_file, 'w') do |f|
          f.write(undercover_output)
        end

        undercover_output
      end

      private

      # Parse arguments
      #
      def parse_arguments!(args)
        OptionParser.new do |opts|
          opts.banner = 'Usage: undercover-report [options]'
          parse_help_options opts
          parse_output_options opts
        end.parse!
      rescue OptionParser::InvalidOption
        args
      end

      # Parse undercover help and plugin help
      #
      def parse_help_options(parser)
        parser.on_tail('-h', '--help', 'Prints undercover help') do
          puts `undercover -h`
          puts parser
          exit
        end
      end

      # Parse provided output path
      #
      def parse_output_options(parser)
        parser.on('-o', '--output path', 'Report output path') do |output|
          @output_path = Pathname output
        end
      end

      # Set default path for report if no argument provided
      # @return [Object]
      #
      def set_default_path
        @output_path = Pathname DEFAULT_PATH
      end

      # Returns the file to write report to
      #
      def output_file
        create_directory!

        File.join(output_directory, File.basename(output_path))
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
        File.join(Dir.getwd, File.dirname(output_path))
      end
    end
  end
end
