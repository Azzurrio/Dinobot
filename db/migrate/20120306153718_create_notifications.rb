class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
		t.string :target_type
	   	t.boolean :read
      # t.timestamps
    end
  end
end
