class DocumentsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  respond_to :html, :xml, :json

  before_action :find_project

  def index
    #TODO: Set .order?
    @documents = Document.where("project_id = ?", @project.id).order(:created_at)
    #@documents = Document.find_by_id(@project)
    respond_with @documents
  end

  def new
    @document = Document.new(project_id: @project.id,
                             public: true,
                             title: 'New document for ' + @project.title,
                             body: 'Content of document')
  end

  def create
    #@document = @project.documents.build(params[:document].permit(:project_id))
    @document =  Document.new(params[:document].permit(:title,
                                                       :body,
                                                       :public,
                                                       :project_id,
                                                       :created_at))
    @document.project = @project
    if @document.save
      redirect_to project_documents_path(@project, method: :get)
    else
      render 'new'
    end
  end

  def show
    @document = Document.find(params[:id])
  end

  def destroy
    @document = Document.find(params[:id]).destroy
    if @document.destroy
      flash[:notice] = "Document deleted"
      redirect_to project_documents_path(@project)
    else
      render 'index'
    end
  end

  def edit
    #@document = Document.find(params[:id])
    update
  end

  def update
    @document = Document.find(params[:id])
    @document.title = params[:content][:document_title][:value]
    @document.body = params[:content][:document_body][:value]

    if @document.update(params[:document])
      flash[:notice] = 'Your document was updated succesfully'

      if request.xhr?
        render json: {status: :success}.to_json
      else
        redirect_to project_documents_path(@project)
      end
    else
      render 'edit'
    end
  end

  def mercury_update
    @document = Document.find(params[:id])
    @document.title = params[:content][:document_title][:value]
    @document.body = params[:content][:document_body][:value]
    @document.save!
    #render text: ""
  end

  private

  def save document
    if @document.save
      flash[:notice] = 'Document has been added'
      redirect_to project_document_path(@project, @document)
    else
      render 'new'
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def find_project
    if params[:project_id]
      @project = Project.find_by_id(params[:project_id])
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def document_params
    params.require(:document).permit(:title,
                                     :body,
                                     :public,
                                     :project_id,
                                     :created_at)
  end
end

