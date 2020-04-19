class CreateInquiries < ActiveRecord::Migration[6.0]
  def change
    create_table :inquiries do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :message

      t.timestamps
    end
  end
end
