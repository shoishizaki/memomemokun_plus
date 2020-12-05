class Todo < ApplicationRecord
  belongs_to :user, dependent: :destroy
  validates :task, presence: true
  validates :priority, presence: true
end
