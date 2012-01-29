class SourcesController < ApplicationController
  set_tab :sources

  load_and_authorize_resource :project
  load_and_authorize_resource :source, :except => [:new]

  def new
    @source = @project.sources.build
  end

  def create
  	@source = Source.new(params[:source])
  	@project.sources << @source
    if @project.save
      redirect_to project_sources_path(@source.project, @source)
    else
      render :action => 'new'
    end
  end

  def destroy   
    @source.destroy  
    redirect_to project_sources_path,
      :notice => "Successfully deleted the source."  
  end  

  def update
    respond_to do |format|
      if @source.update_attributes(params[:source])
        format.html { redirect_to project_sources_path(@project, :notice => 'source was successfully updated.') }
        format.json { respond_with_bip(@source) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@source) }
      end
    end
  end
end