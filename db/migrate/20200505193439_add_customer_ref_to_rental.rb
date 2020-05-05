class AddCustomerRefToRental < ActiveRecord::Migration[6.0]
  def change
    add_reference :rentals, :customer, foreign_key: true
  end
end
