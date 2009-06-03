class PagesController < ApplicationController
  # GET /pages
  # GET /pages.xml
  protect_from_forgery :only => [:create, :update, :destroy]
  layout 'pages', :except => [:auto_complete_for_search_query]
  use_google_charts

  def auto_complete_for_search_query
    @pages = Page.title_like params["search"]["query"]
    render :partial => "search_results"
  end  
  
  def index
    @pages = Page.paginate :page => params[:page], :order => 'total_pageviews DESC', :per_page => 10  
    @page = Page.first(:order => 'total_pageviews desc')
    unless params[:page]
      params[:page]='1'
    end  
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @page = Page.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # # GET /pages/new
  # # GET /pages/new.xml
  # def new
  #   @page = Page.new
  # 
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.xml  { render :xml => @page }
  #   end
  # end
  # 
  # # GET /pages/1/edit
  # def edit
  #   @page = Page.find(params[:id])
  # end
  # 
  # # POST /pages
  # # POST /pages.xml
  # def create
  #   @page = Page.new(params[:page])
  # 
  #   respond_to do |format|
  #     if @page.save
  #       flash[:notice] = 'Page was successfully created.'
  #       format.html { redirect_to(@page) }
  #       format.xml  { render :xml => @page, :status => :created, :location => @page }
  #     else
  #       format.html { render :action => "new" }
  #       format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end
  # 
  # # PUT /pages/1
  # # PUT /pages/1.xml
  # def update
  #   @page = Page.find(params[:id])
  # 
  #   respond_to do |format|
  #     if @page.update_attributes(params[:page])
  #       flash[:notice] = 'Page was successfully updated.'
  #       format.html { redirect_to(@page) }
  #       format.xml  { head :ok }
  #     else
  #       format.html { render :action => "edit" }
  #       format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end
  # 
  # # DELETE /pages/1
  # # DELETE /pages/1.xml
  # def destroy
  #   @page = Page.find(params[:id])
  #   @page.destroy
  # 
  #   respond_to do |format|
  #     format.html { redirect_to(pages_url) }
  #     format.xml  { head :ok }
  #   end
  # end
end
