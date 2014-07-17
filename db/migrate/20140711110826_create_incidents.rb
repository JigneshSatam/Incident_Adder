class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.string :mountain
      t.decimal :latitude
      t.decimal :longitude
      t.datetime :when
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
