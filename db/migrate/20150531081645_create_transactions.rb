class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :security_hash
      t.integer :user_id
      t.integer :diagnostic_id
      t.boolean :completed, :default => false

      t.timestamps
    end
  end
end
