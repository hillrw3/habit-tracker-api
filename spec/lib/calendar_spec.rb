require 'spec_helper'
require 'date'
require_relative '../../lib/calendar'

describe Calendar do
  describe '.beginning_of_week' do
    it 'returns the most recent Sunday' do
      allow(Date).to receive(:today) { Date.new(2020, 12, 25 ) } # Friday
      allow(Time).to receive(:current) { Time.new(2020, 12, 25 ) } # Friday

      expect(Calendar.beginning_of_week).to eq Date.new(2020, 12, 20)
      expect(Calendar.beginning_of_week.sunday?).to be true
    end
  end
end