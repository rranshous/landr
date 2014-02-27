class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :site_url
      t.string :background_url
      t.text :message
      t.string :short_name
      t.belongs_to :user

      t.timestamps
    end
  end
end
