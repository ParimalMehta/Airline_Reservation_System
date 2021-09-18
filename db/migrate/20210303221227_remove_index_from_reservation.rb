class RemoveIndexFromReservation < ActiveRecord::Migration[6.1]
  def change
    remove_index :reservations, :confirmation_number

  end
end
