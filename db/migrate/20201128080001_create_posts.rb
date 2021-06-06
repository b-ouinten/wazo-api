class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.text :content

      t.references :author, index: true

      t.timestamps
    end
  end
end
