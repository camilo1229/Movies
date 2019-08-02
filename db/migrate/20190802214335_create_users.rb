class CreateUsers < ActiveRecord::Migration[5.2]
	def change
		create_table :users do |t|
			t.string :email, null: false
			t.string :password, null: false, default: ""
			t.string :name, null: false
			t.string :last_name, null: false
			t.string :phone, null: false, default: ""
			t.string :avatar, null: false, default: ""
			t.string :status, null: false, default: ""

			t.timestamps
		end
		add_index :users, :email
		add_index :users, :status
	end
end
