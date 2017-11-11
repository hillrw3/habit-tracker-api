require 'active_support/time'

class Calendar
  def self.beginning_of_week
    (Date.today.wday).days.ago.to_date
  end
end