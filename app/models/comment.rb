class Comment < ApplicationRecord

  # Relationships
  belongs_to :author, class_name: 'User'
  belongs_to :post

  # Validations
  validates :content, presence: true

  # Instance methods
end
