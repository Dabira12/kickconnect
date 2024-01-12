class User < ApplicationRecord
  require 'phonelib'
  has_many :listings, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_one :bank_account, dependent: :destroy
  

  validates :username, presence: true, uniqueness: {case_sensitive: false}

  # validates :phone_number, phone:{possible:true,countries: :ng }
  validates :phone_number, presence: true

  validate :phone_number_check


  def phone_number_check
    if (Phonelib.valid_for_country? self.phone_number, 'NG') === false
      
      errors.add(:base,"The phone number is invalid, it should be in the format 080 212 3456 or 80 212 3456")
    end 
  end



  accepts_nested_attributes_for :addresses
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
