class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :current_time
      t.string :content

      t.references :user, null: false
      t.references :post, null: false

      t.timestamps
    end
  end
end
