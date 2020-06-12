class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.string :url
      t.string :thumbnail
      t.timestamps
      # 以下で外部キー制約 user_idを挿入する
      t.references :user, null: false
    end
  end
end
