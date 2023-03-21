class Group < ApplicationRecord
    belongs_to :user
    has_and_belongs_to_many :entities

    validates :name, presence: true, length: { maximum: 250 }
    validates :icon, presence: true, length: { maximum: 500 }
end
