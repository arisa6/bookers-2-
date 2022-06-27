class RemoveProfileImageIdFromBooks < ActiveRecord::Migration[6.1]
  def change
    remove_column :books, :profile_image_id, :integer
  end
end
