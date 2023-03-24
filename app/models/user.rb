class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #   :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :groups
  has_many :entities, foreign_key: 'author_id'

  validates :name, presence: true

  def admin?
    role == 'admin'
  end
end
