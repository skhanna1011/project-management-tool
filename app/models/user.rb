class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, format: { with: /\A[0-9a-zA-Z\.\+\-\_]+@[0-9a-zA-Z\.\-\_]+\.[a-zA-Z]+\z/, message: "should be valid email address" }, uniqueness: true, presence: true
  validates :mobile, presence: true, format: { with: /\A[1-9][0-9]{9}\z/, message: "should be a 10 digit mobile number" }, uniqueness: true, allow_blank: true
  # validates :name, presence: true

  has_many :projects
  has_many :votes

  def admin?
    self.role == 'admin'
  end
end
