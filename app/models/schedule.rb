class Schedule < ApplicationRecord
  include AASM
  belongs_to :movie

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

  def details
    { schedule: schedule, status: status}
  end
end
