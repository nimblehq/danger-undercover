# frozen_string_literal: true

require File.expand_path('spec_helper', __dir__)
require 'undercover/cli'

# rubocop:disable Metrics/BlockLength
module DangerUndercover
  describe DangerUndercover::CLI do
    let!(:mock_message) { 'Test Passed' }
    let!(:directory) { File.join(Dir.getwd, 'coverage') }
    let!(:file) { File.join(Dir.getwd, 'coverage/undercover.txt') }

    before(:each) do
      allow(described_class).to receive(:`).and_return(mock_message)
    end

    after(:all) do
      FileUtils.rm_rf(File.join(Dir.getwd, 'coverage'))
    end

    it 'prints the undercover output' do
      expect(described_class.run).to eql(mock_message)
    end

    it "creates a default folder if doesn't exists" do
      FileUtils.rm_rf(directory)
      described_class.run

      expect(Dir.exist?(directory)).to be true
    end

    it 'creates default file undercover.txt' do
      described_class.run

      expect(File.exist?(file)).to be true
    end

    it 'writes undercover report to default file' do
      described_class.run
      report = File.open(file).read

      expect(report).to eql(mock_message)
    end

    it 'writes undercover report to given file' do
      output_arguments = %w[-o coverage/report.txt]
      report_path = File.join(Dir.getwd, 'coverage/report.txt')
      described_class.run(output_arguments)

      expect(File.exist?(report_path)).to be true
    end
  end
end
# rubocop:enable Metrics/BlockLength
