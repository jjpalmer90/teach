class Lesson < ActiveRecord::Base
  belongs_to :timeslot
  belongs_to :user
end
