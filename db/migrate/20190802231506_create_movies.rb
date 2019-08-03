class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :name, default: '', index: true
      t.string :description, default: ''
      t.string :image, default: ''
      t.string :status, index: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
