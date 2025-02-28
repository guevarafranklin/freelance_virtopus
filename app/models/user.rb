class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one :profile, dependent: :destroy
  has_many :jobs, foreign_key: 'client_id'
  has_many :proposals, foreign_key: 'freelancer_id'
  has_many :contracts_as_client, class_name: 'Contract', foreign_key: 'client_id'
  has_many :contracts_as_freelancer, class_name: 'Contract', foreign_key: 'freelancer_id'
  
  ROLES = %w[client freelancer admin]
  
  validates :role, inclusion: { in: ROLES }
  
  after_create :create_profile
  
  def create_profile
    build_profile.save(validate: false)
  end
  
  def client?
    role == 'client'
  end
  
  def freelancer?
    role == 'freelancer'
  end
  
  def admin?
    role == 'admin'
  end
end