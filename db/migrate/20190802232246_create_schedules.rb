class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.date :schedule, index: true
      t.string :status, index: true
      t.references :movie, foreign_key: true

      t.timestamps
    end
  end
end
