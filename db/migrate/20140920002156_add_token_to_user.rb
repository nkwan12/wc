class AddTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :token, :string
    add_column :users, :token_expr, :datetime
  end
end
