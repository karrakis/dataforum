require 'rails_helper'

RSpec.describe Graph, type: :model do
	context "when file absent" do
		before do
			@graph = Graph.new({
				"users_id" => 1,
				"graph_label" => "testing",
				"graph_type" => "bar",
				"data_source_file_name" => nil,
				"data_source_content_type" => nil,
				"data_source_file_size" => nil,
				"x_field" => "dogs",
    			"y_field" => "cats",
				"separator_fields" => "",
				"data_json" => "{}"
				})
		end
		it { should validate_presence_of(:data_json) }
	end

	context "when data_json absent" do
		before do
			@graph = Graph.new({
				"users_id" => 1,
				"graph_label" => "testing",
				"graph_type" => "bar",
				"data_source_file_name" => "not nil",
				"data_source_content_type" => "not nil",
				"data_source_file_size" => 100,
				"x_field" => "dogs",
    			"y_field" => "cats",
				"separator_fields" => "",
				"data_json" => nil
				})
		end
		it { should have_attached_file(:data_source) }
	end
end