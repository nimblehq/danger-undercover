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
    # Checks the file validity and warns if no file found
    # if valid file is found then if there's no changes,
    # shows the report as message in Danger.
    # If there's reports then it shows the report as warning in danger.
    # @return  [void]
    #
    def report(undercover_path, sticky: true)
      if valid_file? undercover_path
        report = File.open(undercover_path).read
        if report.match(/No coverage is missing in latest changes/)
          message(report, sticky: sticky)
        else
          warn(report, sticky: sticky)
        end
      else
        fail('undercover: Data not found')
      end
    end

    private

    # Return accepted file format
    # @return [String] Accepted format
    #
    def accepted_file_format
      '.txt'
    end

    # Checks if the file exists and the file is valid
    # @return [Boolean] File validity
    #
    def valid_file?(undercover_path)
      File.exist?(undercover_path) && (File.extname(undercover_path) == accepted_file_format)
    end
  end
end
