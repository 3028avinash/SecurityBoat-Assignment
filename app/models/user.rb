class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :name,:password,:mobile_number,:email, presence: true

end