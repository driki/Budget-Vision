class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string    :name
      t.string    :state
      t.boolean   :is_verified
      t.integer   :population
      t.float     :pop_sq_mi
      t.float     :total_sq_mi
      t.integer   :housing_units
      t.float     :housing_percent_vacant
      t.float     :diversity
      t.string    :fips
      t.string    :gnis
      t.integer   :opener_id
      t.float     :latitude
      t.float     :longitude
      t.boolean   :is_demo

      t.timestamps
    end
    add_index(:organizations, [:name, :state])
    add_index(:organizations, [:latitude, :longitude])

  end
end
