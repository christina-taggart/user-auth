class User < ActiveRecord::Base
  validates :email, uniqueness: true

  def self.authenticate(params)
    begin
      user = User.where(email: params[:email]).first
      user.password == Digest::SHA256.hexdigest(params[:password])
    rescue
      false
    end
  end
end
