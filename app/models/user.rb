class User < ApplicationRecord
    has_many :groups, class_name: 'Group', dependent: :destroy
    has_many :entities, class_name: 'Entity', foreign_key: 'author_id', dependent: :destroy

    validates :full_name, presence: true
end
