class AddDataJsonToGraph < ActiveRecord::Migration[5.0]
  def change
  	change_table :graphs do |t|
      t.text "data_json"
    end
  end
end
