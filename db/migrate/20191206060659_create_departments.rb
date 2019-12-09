class CreateDepartments < ActiveRecord::Migration[6.0]
  def change
    create_table :departments, id: false do |t|
      t.integer :code
      t.string :name
      t.float :area
      t.float :perimeter
      t.float :hectares
      t.string :region
      t.geometry :geometry

      t.timestamps
    end
    add_index :departments, :code, unique: true
  end
end
