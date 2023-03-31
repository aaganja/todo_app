class Project < ApplicationRecord
	belongs_to :user
	has_many :tasks

	validates :title, presence: true, uniqueness: { scope: :user_id }

	accepts_nested_attributes_for :tasks
end
