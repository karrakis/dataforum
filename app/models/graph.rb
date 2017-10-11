class Graph < ActiveRecord::Base
	has_attached_file :data_source
	has_many :forum_posts
	validates :graph_label, :graph_type, :x_field, :y_field, presence: true	


		validates_attachment_content_type :data_source, content_type: /\Atext\/.*\Z/, if: :file_presence
		validates_attachment_size :data_source, less_than: 1.megabytes, if: :file_presence

		validates_attachment_file_name :data_source, :matches => [/csv\Z/, /tsv\Z/, /txt\Z/], if: :file_presence
	
		validates :data_json, presence: true, unless: :file_presence
	

	def file_presence
		!self.data_source.to_s.match(/missing.png/)
	end

  def compare_field
  end

  def contrast_field
  end

  def make_data
  	if self.data_json
		file = self.data_json
	else
		csv = CSV.parse(Paperclip.io_adapters.for(self.data_source).read, col_sep: "\t", headers: true)
		csv = csv.map{|m| m.to_h }.to_json
		file = csv

		pp file
	end

	output = {}
	output['graph_label'] = self.graph_label
	output['x_field'] = self.x_field
	output['y_field'] = self.y_field
	output['graph_type'] = self.graph_type
	output['separator_fields'] = self.separator_fields
	output['file'] = file
	output = output.to_json
	
	output
  end

  def self.make_data_sample(raw, options)
  	csv = CSV.parse(raw, col_sep: "\t", headers: true)
  	csv = csv.map{|m| m.to_h}.to_json

	output = {}
  	output['graph_label'] = options['graph_label']
  	output['x_field'] = options['x_field']
	output['y_field'] = options['y_field']
	output['graph_type'] = options['graph_type']
	output['separator_fields'] = options['separator_fields']
	output['file'] = csv
	output = output.to_json

	output
  end

  def self.search(search)
  	puts "search: #{search}"
	if search
		pp "searching occurred"
		self.where('x_field like ? or y_field like ? or graph_label like ? or separator_fields like ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
	else
		self.all
	end
  end
end