# frozen_string_literal: true

module Danger
  # Report missing coverage report using undercover and danger-undercover
  #
  # You have to use [undercover](https://github.com/grodowski/undercover) to gather
  # undercover report and send the report to this plugin so that danger-undercover
  # can use it.
  #
  # @example Report missing coverage report
  #
  #          undercover.report('coverage/undercover.txt')
  #
  # @see  nimblehq/danger-undercover
  # @tags ruby, code-coverage, simplecov, undercover, danger, simplecov-lcov
  #
  class DangerUndercover < Plugin
    VALID_FILE_FORMAT = '.txt'
    DEFAULT_PATH = 'coverage/undercover.txt'

    # Checks the file validity and warns if no file is found
    # if a valid file is found then if there are no changes,
    # shows the report as a message in Danger.
    # If there are reports then it shows the report as a warning in danger.
    # @return  [void]
    #
    def report(undercover_path = DEFAULT_PATH, sticky: true, in_line: false)
      return warn('Undercover: coverage report cannot be found.') unless valid_file? undercover_path

      report = File.open(undercover_path).read.force_encoding('UTF-8')

      if report.match(/some methods have no test coverage/)
        return warn(report, sticky: sticky) unless in_line

        report.each_line.with_index do |line, i|
          next unless line.strip.start_with?("loc:")

          _, filename, from_line, to_line = line.match(/loc:\s([^:]*):(\d+):(\d+)/)
          warn("Coverage reported 0 hits #{line}", file: filename, line: from_line.to_i, sticky: sticky)
        end

        fail(report, sticky: sticky)
      else
        message(report, sticky: sticky)
      end
    end

    private

    # Checks if the file exists and the file is valid
    # @return [Boolean] File validity
    #
    def valid_file?(undercover_path)
      File.exist?(undercover_path) && (File.extname(undercover_path) == VALID_FILE_FORMAT)
    end
  end
end
