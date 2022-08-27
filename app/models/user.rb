class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :quizzes
  has_many :packages
  has_many :quiz_reports

  has_many :likes
  has_many :liked_quizzes, through: :likes, source: :quiz

  validates :nickname, presence: true
end
