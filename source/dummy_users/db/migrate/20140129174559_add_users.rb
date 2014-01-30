class AddUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :full_name, :password, :email
    end
  end
end
