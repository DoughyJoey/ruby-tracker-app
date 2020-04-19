class AddDescriptionToInquiries < ActiveRecord::Migration[6.0]
  def change
    add_column :inquiries, :description, :string
  end
end
