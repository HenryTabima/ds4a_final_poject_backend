class CreateMetrics < ActiveRecord::Migration[6.0]
  def change
    create_table :metrics do |t|
      t.references :department, null: false
      t.references :type, null: false
      t.float :value
      t.date :year

      t.timestamps
    end
    add_foreign_key :metrics, :departments, column: :department_id, primary_key: :code
    add_foreign_key :metrics, :metric_types, column: :type_id
  end
end
