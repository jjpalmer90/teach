class Lesson < ActiveRecord::Base
  extend SimpleCalendar
  has_calendar :attribute => :starts_at

  # Or set a custom attribute for simple_calendar to sort by
  # has_calendar :attribute => :your_starting_time_column_name
end