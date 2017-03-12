class Article < ApplicationRecord
  belongs_to :user
  has_many :comments
  validates :title, presence: true
  validates :body, presence: true

  default_scope { order(created_at: :desc)}
end
