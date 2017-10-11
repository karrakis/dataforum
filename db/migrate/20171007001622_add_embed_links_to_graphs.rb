class AddEmbedLinksToGraphs < ActiveRecord::Migration[5.0]
  def change
  	change_table :graphs do |t|
  		t.text "embed_link"
  		t.text "direct_link"
  	end
  end
end