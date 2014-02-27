class SitesController < ApplicationController
  before_action :set_site, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  def landing
    short_name = params[:short_name]
    logger.debug "USER PASSED: #{short_name}"
    @site = Site.where(short_name: short_name).first
    @prospect = Prospect.new
    logger.debug "FOUND SITE: #{@site}"
    render layout: 'landing'
  end

  def signup
    prospect = Prospect.new(prospect_params)
    short_name = params[:short_name]
    site = Site.where(short_name: short_name).first
    prospect.site = site
    prospect.save
    flash[:notice] = "Thanks, We'll email you when ready"
    redirect_to action: :landing
  end

  # GET /sites
  # GET /sites.json
  def index
    #@sites = Site.all
    @sites = current_user.sites
  end

  # GET /sites/1
  # GET /sites/1.json
  def show
  end

  # GET /sites/new
  def new
    @site = Site.new
  end

  # GET /sites/1/edit
  def edit
  end

  # POST /sites
  # POST /sites.json
  def create
    @site = Site.new(site_params)
    @site.user = current_user

    respond_to do |format|
      if @site.save
        format.html { redirect_to @site, notice: 'Site was successfully created.' }
        format.json { render action: 'show', status: :created, location: @site }
      else
        format.html { render action: 'new' }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sites/1
  # PATCH/PUT /sites/1.json
  def update
    respond_to do |format|
      if @site.update(site_params)
        format.html { redirect_to @site, notice: 'Site was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site.destroy
    respond_to do |format|
      format.html { redirect_to sites_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site
      @site = Site.find(params[:id])
      if @site.user != current_user
        raise "SOMETHING IS FUNKY"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_params
      params.require(:site).permit(:site_url, :background_url, :message, :short_name)
    end

    def prospect_params
      params.require(:prospect).permit(:email)
    end
end
