class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops, id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
  end
end
