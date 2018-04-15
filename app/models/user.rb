class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name,  presence: true

  has_many :reviews, dependent: :destroy

  def full_name
    "#{first_name} #{last_name}"
  end
end
