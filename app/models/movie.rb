class Movie < ApplicationRecord
  include AASM

  belongs_to :user
  has_many :schedules
  accepts_nested_attributes_for :schedules

  aasm column: "status", skip_validation_on_save: true do
    state :active, initial: true
    state :inactive

    event :enable do
      transitions from: :inactive, to: :active
    end

    event :disable do
      transitions from: :active, to: :inactive
    end

  end

  def small_details
    {
      name: name, description: description, image: image, owner: user.profile_details
    }
  end

  def details
    {
      name: name, description: description, image: image, owner: user.profile_details, schedules: schedules.collect(&:details)
    }
  end

  def self.by_day(date)
    active.includes(:schedules).where("schedules.schedule = ?", date).references(:schedules)
  end
end
