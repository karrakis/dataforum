class Graph < ActiveRecord::Base
  has_attached_file :data_source
  validates :graph_label, :x_field, :y_field, presence: true
    
  validates_attachment_content_type :data_source, content_type: /\Atext\/.*\Z/
  validates_attachment_size :data_source, less_than: 1.megabytes

  validates_attachment_file_name :data_source, :matches => [/csv\Z/, /tsv\Z/, /txt\Z/]

  def make_data
	  csv = CSV.parse(Paperclip.io_adapters.for(self.data_source).read, col_sep: "\t", headers: true)
	  csv = csv.map{|m| m.to_h }.to_json
	  file = csv

	  output = {}
	  output['graph_label'] = self.graph_label
	  output['x_field'] = self.x_field
	  output['y_field'] = self.y_field
	  output['file'] = file
	  pp output
	  output = output.to_json
	  pp output
	  output
  end
end