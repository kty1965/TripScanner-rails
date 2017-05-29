class Review < ApplicationRecord

  belongs_to :writer, class_name: "User"
  belongs_to :owner, class_name: "User"
  belongs_to :trip

  validates :view_scope, presence: true, inclusion: { in: %w(public private) }
  validates :rate, inclusion: { in: 0.0..5.0 }, allow_nil: true

  state_machine initial: :pending do
    event :write do
      transition :pending => :written
    end
  end

  scope :pending, -> { where(state: "pending") }
  scope :written, -> { where(state: "written") }
end
