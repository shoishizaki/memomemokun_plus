class Memo < ApplicationRecord
  belongs_to :user, dependent: :destroy
  validates :category, presence: true
  validates :content, presence: true
end
