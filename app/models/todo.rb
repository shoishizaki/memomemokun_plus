class Todo < ApplicationRecord
  belongs_to :user
  validates :task, presence: true
  validates :priority, presence: true
end
