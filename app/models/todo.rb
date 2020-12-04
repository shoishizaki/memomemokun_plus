class Todo < ApplicationRecord
  belongs_to :user, dependent: :destroy
  validates :completed, presence: true
  validates :task, presence: true
  validates :priority, presence: true
end
