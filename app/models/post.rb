class Post < ApplicationRecord

  # Relationships
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy

  # Validations
  validates :content, presence: true

  # Instance methods

end
