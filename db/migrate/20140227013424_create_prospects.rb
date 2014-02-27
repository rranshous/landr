class CreateProspects < ActiveRecord::Migration
  def change
    create_table :prospects do |t|
      t.string :email
      t.belongs_to :site

      t.timestamps
    end
  end
end
