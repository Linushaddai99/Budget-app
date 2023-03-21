class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #   :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :groups, class_name: 'Group', dependent: :destroy
  has_many :entities, class_name: 'Entity', foreign_key: 'author_id', dependent: :destroy

  validates :name, presence: true
end
