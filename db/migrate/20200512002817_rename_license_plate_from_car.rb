class RenameLicensePlateFromCar < ActiveRecord::Migration[6.0]
  def change
    rename_column :cars, :licence_plate, :license_plate
  end
end
