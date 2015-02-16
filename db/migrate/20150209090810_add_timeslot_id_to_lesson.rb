class AddTimeslotIdToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :timeslot_id, :integer
  end
end
