class User < ApplicationRecord
  has_many :listings, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_one :bank_account, dependent: :destroy
  

  validates :username, presence: true, uniqueness: {case_sensitive: false}
  

  accepts_nested_attributes_for :addresses
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
