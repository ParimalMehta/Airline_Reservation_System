class AddKeyToFeedbacks < ActiveRecord::Migration[6.1]
  def change
    add_reference :feedbacks, :user, null: false, foreign_key: true
    add_reference :feedbacks, :flight, null: false, foreign_key: true
  end
end
