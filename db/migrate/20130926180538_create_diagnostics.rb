class CreateDiagnostics < ActiveRecord::Migration
  def change
    create_table :diagnostics do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
