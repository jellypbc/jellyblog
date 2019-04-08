module TimeScopes
  extend ActiveSupport::Concern

  included do
    scope :daily, lambda { where(created_at: 1.day.ago..Time.now ) }
    scope :yesterday, lambda { where(created_at: 2.days.ago..1.day.ago) }

    scope :thisweek, lambda { where(created_at: 7.days.ago..Time.now) }
    scope :lastweek, lambda { where(created_at: 2.weeks.ago..1.week.ago) }

    scope :two_weeks, lambda { where(created_at: (2.weeks.ago)..(1.week.ago)) }
    scope :three_weeks, lambda { where(created_at: (3.weeks.ago)..(2.weeks.ago)) }
    scope :four_weeks, lambda { where(created_at: (4.weeks.ago)..(3.weeks.ago)) }
    scope :five_weeks, lambda { where(created_at: (5.weeks.ago)..(4.weeks.ago)) }

    scope :lastmonth, lambda { where(created_at: 1.month.ago..Time.now) }
    scope :amonthago, lambda { where(created_at: 2.month.ago..1.month.ago) }
    scope :sixmonths, lambda { where(created_at: 6.month.ago..Time.now) }
    scope :thisyear, lambda { where(created_at: 12.month.ago..Time.now) }

    scope :since_tuesday, lambda { where(created_at: (Time.now.beginning_of_week(:wednesday))..Time.now ) }
    scope :since_last_tuesday, lambda { where(created_at: 1.week.ago.beginning_of_week(:wednesday)..1.week.ago.end_of_week(:wednesday)) }
    scope :since_this_month, lambda { where(created_at: (Time.now.beginning_of_month..Time.now )) }
  end
end