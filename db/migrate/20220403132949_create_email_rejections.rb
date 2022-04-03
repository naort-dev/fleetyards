class CreateEmailRejections < ActiveRecord::Migration[7.0]
  def change
    create_table :email_rejections, id: :uuid do |t|
      t.string :email

      t.timestamps
    end
  end
end
