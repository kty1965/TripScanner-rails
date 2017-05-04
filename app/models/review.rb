class Review < ApplicationRecord

  belongs_to :writer, class_name: "User"
  belongs_to :owner, class_name: "User"
  belongs_to :trip

  validates :view_scope, presence: true, inclusion: { in: %w(public private) }
  validates :rate, inclusion: { in: 0.0..5.0 }
  validates :content, presence: true
end
