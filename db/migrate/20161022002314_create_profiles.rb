class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.date   :birthday
      t.string :birthplace
      t.string :currentplace
      t.string :education
      t.string :occupation
      t.text   :bio

      t.timestamps
    end
  end
end
