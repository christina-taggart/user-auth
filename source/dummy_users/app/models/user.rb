class User < ActiveRecord::Base
  def self.authenticate(email, password)
    !self.where(email: email, password: password).empty?
  end
end