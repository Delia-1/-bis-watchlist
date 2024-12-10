class Movie < ApplicationRecord
  belongs_to :user
  has_many :bookmarks
  has_many :lists, through: :bookmarks

  validates :title, :overview, presence: true
  validates :title, :overview, uniqueness: true
end
