class AddRoleToUsers < ActiveRecord::Migration

  # Redefine model class.
  class User < ActiveRecord::Base
    GUEST_ROLE = 'guest'
  end

  def change
    add_column :users, :role, :string, :null => false, :default => User::GUEST_ROLE
  end
end
