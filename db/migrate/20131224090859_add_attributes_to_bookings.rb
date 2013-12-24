class AddAttributesToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :description, :text
    add_column :bookings, :url, :string
  end
end
