class CreateProposals < ActiveRecord::Migration[8.0]
  def change
    create_table :proposals do |t|
      t.references :job, null: false, foreign_key: true
      t.references :freelancer, null: false, foreign_key: true
      t.text :cover_letter
      t.string :status

      t.timestamps
    end
  end
end
