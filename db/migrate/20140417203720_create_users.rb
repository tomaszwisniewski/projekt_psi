class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nick
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
