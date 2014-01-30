class User < ActiveRecord::Base
  validates :email, uniqueness: true

  def self.authenticate(email, password)
    if User.where(email: email, password: password).empty?
      false
    else
      true
    end
  end
end
