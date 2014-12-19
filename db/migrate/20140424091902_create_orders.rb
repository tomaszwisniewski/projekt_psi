class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.string :address

      t.timestamps
    end
  end
end
