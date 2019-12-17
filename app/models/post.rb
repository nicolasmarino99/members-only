# frozen_string_literal: true

class Post < ApplicationRecord
  validates :title, presence: true, length: { in: 5..25 }
  validates :content, presence: true, length: { in: 5..240 }

  belongs_to :user
end
