class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, 
                  :remember_me, :role, :avatar, :gender, :avatar_id,
                  :birthday, :home_address, :school_name, :school_address, :qq, :parent_name
  # attr_accessible :title, :body
  attr_accessor :login

  validates :username,
    :uniqueness => {
      :case_sensitive => false
    }

  has_many :user_questions
  has_many :questions, through: :user_questions
  has_many :exams, dependent: :destroy
  
  has_many :user_units
  has_many :units, through: :user_units

  has_one :credit

  has_and_belongs_to_many :stages

  before_save :ensure_authentication_token
  after_create :create_its_credit

  has_many :orders

  mount_uploader :avatar, ImageUploader

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  protected

  def create_its_credit
    self.create_credit
  end
end
