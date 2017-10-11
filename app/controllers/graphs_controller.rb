class GraphsController < ApplicationController
    extend ActiveModel::Naming


  before_action :set_user
  before_action :set_graph, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!, only: [:destroy]

  # GET /graphs
  # GET /graphs.json
  def index
    @search_terms = params[:search]
    if @search_terms
      @graphs = Graph.search(@search_terms).paginate(:page => params[:page], :per_page => 50)
    else
      @graphs = Graph.paginate(:page => params[:page], :per_page => 50)
    end
  end

  # GET /graphs/1
  # GET /graphs/1.json
  def show
    @forum_posts = ForumPost.where(graphs_id: @graph.id, parent_id: nil)
  end

  # GET /graphs/new
  def new
    @graph = Graph.new
  end

  # GET /graphs/1/edit
  def edit
  end

  # POST /graphs
  # POST /graphs.json
  def create
  	#graph_params[:data_json] = CSV.parse(Paperclip.io_adapters.for(params[:graph][:data_source]).read).to_json
    data_insert = graph_params
    data_insert = @user ? data_insert.merge(users_id: @user.id) : data_insert
    @graph = Graph.new(data_insert)

    respond_to do |format|
      if @graph.save
        data_insert = data_insert.merge(embed_link: "#{request.base_url}/embed/#{@graph.id}", direct_link: "#{request.base_url}/graphs/#{@graph.id}")
        @graph.update(data_insert)
        format.html { redirect_to @graph, notice: 'Graph was successfully created.' }
        format.json { render action: 'show', status: :created, location: @graph }
      else
        format.html { render action: 'new' }
        format.json { render json: @graph.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /graphs/1
  # PATCH/PUT /graphs/1.json
  def update
    respond_to do |format|
      if @graph.update(graph_params)
        format.html { redirect_to @graph, notice: 'Graph was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @graph.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /graphs/1
  # DELETE /graphs/1.json
  def destroy
    if (@user and @graph.users_id == @user.id)
      @graph.destroy 
      respond_to do |format|
        format.html { redirect_to graphs_url }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { render html: 'You must own this graph to destroy it.' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_graph
      @graph = Graph.find(params[:id])
    end

    def set_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def graph_params
      params.require(:graph).permit(:graph_label, :graph_type, :data_source, :data_source_file_name, :data_source_file_size, :data_source_content_type, :data_json, :x_field, :y_field, :separator_fields)
    end
	
end