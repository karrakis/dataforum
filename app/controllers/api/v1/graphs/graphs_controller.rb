class Api::V1::Graphs::GraphsController < BaseApiController
  before_action :set_graph, only: [:show, :edit, :update, :destroy]


  # GET /graphs/1
  # GET /graphs/1.json
  def show
  end

  # GET /graphs/new
  def new
    @graph = Graph.new(graph_params)
  end

  # POST /graphs
  # POST /graphs.json
  def create
    @graph = Graph.where(id: graph_params[:id]).first
    if @graph
      @graph.update(graph_params)
    else
      @graph = Graph.new(graph_params.merge(users_id: @user.id))
    end

    #DownWorker.perform_async(@graph['image_link'])

    #respond_to do |format|
      if @graph.save
        format.json { render json: @graph.to_json }
      else
        format.json { render json: @graph.errors.to_json, status: :unprocessable_entity }
      end
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_graph
      @graph = Graph.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def graph_params
      params.require(:graph).permit(:graph_label, :graph_type, :x_field, :y_field, :separator_fields, :data_json)
    end
end