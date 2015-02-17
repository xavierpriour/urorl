class UrlsController < ApplicationController
  before_action :set_url, only: [:show, :edit, :update, :destroy]

  # GET /urls
  # GET /urls.json
  def index
    @urls = Url.all
  end

  # GET /urls/1
  # GET /urls/1.json
  def show
  end

  # GET /urls/new
  def new
    @url = Url.new
  end

  # POST /urls
  # POST /urls.json
  def create
    # check if there is already an Url for these params
    @url = Url.where(long: url_params['long']).first
    if (@url.nil?)
      # TODO check if the long URL is a valid one
      @url = Url.new(url_params)
    end
    respond_to do |format|
      if @url.id || @url.save
        format.html { redirect_to @url, notice: 'Your URL was successfully shortened.' }
        format.json { render :show, status: :created, location: @url }
      else
        format.html { render :new }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /urls/1
  # DELETE /urls/1.json
  def destroy
    @url.destroy
    respond_to do |format|
      format.html { redirect_to urls_url, notice: 'Url was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def go
    @url = Url.where("short = :short", params).first
    if (@url.nil?)
      # if incorrect short url, send back to main url
      redirect_to urls_url
    else
      redirect_to @url.long
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_url
      @url = Url.find(params[:id])
      @url.full = go_urls_url(@url.short)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def url_params
      params.require(:url).permit(:long, :short)
    end
end
