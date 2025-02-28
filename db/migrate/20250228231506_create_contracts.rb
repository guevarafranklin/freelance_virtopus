class CreateContracts < ActiveRecord::Migration[8.0]
  def change
    create_table :contracts do |t|
      t.references :job, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.references :freelancer, null: false, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.decimal :amount
      t.string :status

      t.timestamps
    end
  end
end
