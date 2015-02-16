class AddTimeToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :booked_time, :time
    add_column :lessons, :booked_date, :date
    add_column :lessons, :lesson_length, :integer
    add_column :lessons, :lesson_location, :string
    remove_column :lessons, :starts_at
    remove_column :lessons, :ends_at
  end
end
