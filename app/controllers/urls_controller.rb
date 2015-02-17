##
# Exposes usual REST operations on URL model (without edit/update),
# as well as a 'go' action to redirect to original URL
# 
class UrlsController < ApplicationController
  before_action :set_url, only: [:show, :destroy]

  # GET /urls
  # GET /urls.json
  def index
    @urls = Url.all
  end

  # GET /urls/1
  # GET /urls/1.json
  def show
    if(@url.nil?)
      respond_to do |format|
        format.html { redirect_to urls_url, notice: 'Incorrect URL ID.' }
        format.json { head :no_content }
      end
    end
  end

  # GET /urls/new
  def new
    @url = Url.new
  end

  # POST /urls
  # POST /urls.json
  def create
    # check if there is already an Url for these params
    @url = Url.where(long: url_params[:long]).first
    if (@url.nil?)
      # TODO check if the long URL is a valid one
      @url = Url.new(url_params)
    end
    respond_to do |format|
      if @url.id || @url.save
        format.html { redirect_to @url, notice: 'Your URL was successfully transformed.' }
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
    if (!@url.nil?)
      @url.destroy
    end # if not we silently ignore
    respond_to do |format|
      format.html { redirect_to urls_url, notice: 'The URL was deleted.' }
      format.json { head :no_content }
    end
  end

  # GET /urls/go/rst45a
  def go
    @url = Url.where(short: params[:short]).first
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
      # we use where instead of find(id) because we want to handle
      # incorrect ids gracefully.
      @url = Url.where(id: params[:id]).first
      if (!@url.nil?)
        @url.full = go_urls_url(@url.short)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def url_params
      params.require(:url).permit(:long)
    end
end
