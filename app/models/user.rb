class User < ActiveRecord::Base
  belongs_to :company

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :encryptable, :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :role, :roles, :email, :password, :password_confirmation, :remember_me, :mobile, :name, :login_name, :gym_ids, :company_id
  attr_accessor :role
  attr_accessor :login

  validates :name, presence: true
  validates :login_name, presence: true, uniqueness: { case_sensitive: false }
  #validates :mobile, uniqueness: true, length: { is: 11 }, numericality: true

  scope :as_role, lambda { |role| where("#{table_name}.roles_mask & #{ROLES.index(role).nil? ? 0 : (2**ROLES.index(role))}") }

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(login_name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  ROLES = %w[admin manager accountant]

  def display_name
    name || login_name || email
  end

  def role=(role)
    return if role.to_s == 'admin'

    @role = role
    self.roles = [role.to_s]
  end

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def is?(role)
    roles.include?(role.to_s)
  end

  def backend?
    is?(:admin) || is?(:manager) || is?(:accountant)
  end

  before_create :set_default_role

  def bookmark(gym)
    unless self.bookmarked_gyms.include?(gym)
      self.bookmarked_gyms << gym
    end
  end

  def unbookmark(gym)
    if self.bookmarked_gyms.include?(gym)
      self.bookmarked_gyms.delete(gym)
    end
  end

  protected

  def set_default_role
    if User.count == 0
      self.roles = ['admin']
    end
  end


end
