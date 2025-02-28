class CreateTimeEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :time_entries do |t|
      t.references :contract, null: false, foreign_key: true
      t.references :freelancer, null: false, foreign_key: true
      t.decimal :hours
      t.text :description
      t.date :date
      t.string :status

      t.timestamps
    end
  end
end
