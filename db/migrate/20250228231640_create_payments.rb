class CreatePayments < ActiveRecord::Migration[8.0]
  def change
    create_table :payments do |t|
      t.references :contract, null: false, foreign_key: true
      t.decimal :amount
      t.string :status
      t.string :payment_method
      t.string :transaction_id

      t.timestamps
    end
  end
end
