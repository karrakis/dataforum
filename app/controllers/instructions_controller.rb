class InstructionsController < ApplicationController
	def index
		@default_pie_data = "mammal\tvalue\ndogs\t10\npeople\t8\ncats\t5"
		@default_bar_data = "mammal\tvalue\ndogs\t10\npeople\t8\ncats\t5"
		@default_line_data = "legs\teyes\tbeastie\n6\t2\tants\n8\t8\tspiders\n3\t2\tcats\n5\t1\tants\n7\t6\tspiders\n4\t4\tcats\n4\t3\tants\n5\t4\tspiders\n1\t1\tcats"
		
		@pieData = Graph.make_data_sample(@default_pie_data,{
				'graph_label' => 'Example Pie Chart',
				'x_field' => 'mammal',
				'y_field' => 'value',
				'graph_type' => 'pie',
				'separator_fields' => ''
			})

		@barData = Graph.make_data_sample(@default_bar_data,{
				'graph_label' => 'Example Bar Graph',
				'x_field' => 'mammal',
				'y_field' => 'value',
				'graph_type' => 'bar',
				'separator_fields' => ''
			})

		@lineData = Graph.make_data_sample(@default_line_data,{
				'graph_label' => 'Example Line Graph',
				'x_field' => 'legs',
				'y_field' => 'eyes',
				'graph_type' => 'line',
				'separator_fields' => 'beastie'
			})
	end
end	