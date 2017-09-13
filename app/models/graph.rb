class Graph < ActiveRecord::Base
  has_attached_file :data_source
  validates :graph_label, :x_increment, :y_increment, :x_max, :y_max, :x_field, :y_field, presence: true
    
  validates_attachment_content_type :data_source, content_type: /\Atext\/.*\Z/
  validates_attachment_size :data_source, less_than: 1.megabytes

  validates_attachment_file_name :data_source, :matches => [/csv\Z/, /tsv\Z/, /txt\Z/]

end