class Book < ApplicationRecord
  belongs_to :author, optional: false

  validates :title, presence: true
end
