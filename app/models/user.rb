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
                  :birthday, :home_address, :school_name, :school_address, :qq, :parent_name,
                  :phone, :class_no
  # attr_accessible :title, :body
  attr_accessor :login, :current_user

  # validates :username,
  #   :uniqueness => {
  #     :case_sensitive => false
  #   }

  has_many :user_questions
  has_many :questions, through: :user_questions
  has_many :exams, dependent: :destroy
  
  has_many :user_units
  has_many :units, through: :user_units
  has_many :user_stages
  has_many :stages, through: :user_stages
  has_many :user_grades
  has_many :grades, through: :user_grades

  has_one :credit

  before_save :ensure_authentication_token
  after_create :create_its_credit

  has_many :orders

  has_many :child_parents, foreign_key:"parent_id", dependent: :destroy
  has_many :children, through: :child_parents, source: :child

  has_many :reverse_child_parents, foreign_key:"child_id", class_name:"ChildParent", dependent: :destroy
  has_many :parents, through: :reverse_child_parents, source: :parent

  mount_uploader :avatar, ImageUploader

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def boolean_verify_parent(parent, child)  #根据child_id和parent_id 判断是否互相验证
    child_parent = ChildParent.where(parent_id: parent.id, child_id: child.id).first
    if !child_parent.blank?
      return child_parent.verify_parent
    else
      return false
    end
  end

  def boolean_verify_parents   #根据child_id 来获取没有验证的parents
    child_parents = ChildParent.where(child_id: self.id)
    parents = Array.new
    child_parents.each do |child_parent|
      if child_parent.verify_parent == false
        parent = User.find(child_parent.parent_id)
        parents.push(parent)
      end
    end
    return parents
  end

  protected

  def create_its_credit
    self.create_credit
  end


end
