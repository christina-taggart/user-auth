class User < ActiveRecord::Base
  validates :email, uniqueness: true

  def self.authenticate(params)
    user = User.where(email: params[:email]).first
    user.password == params[:password]
  end
end
