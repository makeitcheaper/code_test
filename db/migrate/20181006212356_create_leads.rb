class CreateLeads < ActiveRecord::Migration[5.1]
  def change
    create_table :leads do |t|
      t.string :name
      t.string :business_name
      t.string :email
      t.string :telephone_number

      t.timestamps
    end
  end
end
