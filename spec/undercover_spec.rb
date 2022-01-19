# frozen_string_literal: true

require File.expand_path('spec_helper', __dir__)

module Danger
  describe Danger::DangerUndercover do
    it 'is a Danger plugin' do
      expect(Danger::DangerUndercover.new(nil)).to be_a Danger::Plugin
    end

    describe 'Dangerfile' do
      before do
        @dangerfile = testing_dangerfile
        @undercover = @dangerfile.undercover
      end

      it 'fails if file is not found' do
        @undercover.report('spec/fixtures/missing_file.txt')

        expect(@dangerfile.status_report[:errors]).to eq(['Undercover: coverage report cannot be found.'])
      end

      it 'shows success message if nothing to report' do
        report_path = 'spec/fixtures/undercover_passed.txt'
        @undercover.report(report_path)
        report = File.read(report_path)

        expect(@dangerfile.status_report[:messages]).to eq([report])
      end

      it 'shows warnings if undercover has a report' do
        report_path = 'spec/fixtures/undercover_failed.txt'
        @undercover.report(report_path)
        report = File.read(report_path)

        expect(@dangerfile.status_report[:warnings]).to eq([report])
      end
    end
  end
end
