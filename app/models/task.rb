class Task < ApplicationRecord
  belongs_to :user
  has_many :comments
  validates :title,:description,:due_date, presence: true

end
