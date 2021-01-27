class CreateVacunas < ActiveRecord::Migration[6.0]
  def change
    create_table :vacunas do |t|
      t.datetime :date

      t.timestamps
    end
  end
end
