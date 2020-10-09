class CreateCompanyTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :company_types do |t|
      t.string :name
      t.string :code
      t.string :affiliation

      t.timestamps
    end
  end
end
