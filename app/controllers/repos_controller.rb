class ReposController < ApplicationController
  before_action :set_repo, only: [:edit, :update, :destroy]
require 'open-uri'
require 'json'


  BASE_URL = "https://api.github.com/"

  def preview

  end


  # GET /repos
  # GET /repos.json
  def index


# # Exchange your oauth_token and oauth_token_secret for an AccessToken instance.
# def prepare_access_token(oauth_token, oauth_token_secret)
#   consumer = OAuth::Consumer.new("e24305f14f7f9a67c465", "604015f905f6207ec29f3661b952397663d58347",
#     { :site => "https://api.github.com/",
#       :scheme => :header
#     })
#   # now create the access token object from passed values
#   token_hash = { :oauth_token => oauth_token,
#                  :oauth_token_secret => oauth_token_secret
#                }
#   access_token = OAuth::AccessToken.from_hash(consumer, token_hash )
#   return access_token
# end

# # Exchange our oauth_token and oauth_token secret for the AccessToken instance.
# access_token = prepare_access_token("abcdefg", "hijklmnop")
# # use the access token as an agent to get the home timeline
# @response = access_token.request(:get, "https://api.github.com/repos/rails/rails/collaborators")


# curl https://api.github.com/repos/rails/rails/collaborators?client_id=e24305f14f7f9a67c465&client_secret=604015f905f6207ec29f3661b952397663d58347


    # url = "https://github.com/login/oauth/authorize"

    # @token = JSON.parse(open(url).read)

    @repo = Repo.new
  end

  # GET /repos/1
  # GET /repos/1.json
  def show
    user= params[:user]
    repo= params[:repo]
    url = BASE_URL + "repos/" + user + "/" + repo + "/collaborators"+ "?client_id=e24305f14f7f9a67c465&client_secret=604015f905f6207ec29f3661b952397663d58347"
    # url = BASE_URL + "repos/rails/rails/collaborators"
    # url = BASE_URL + "repositories"
    @repo = JSON.parse(open(url).read)
    @results = []


    @repo.each do |doc|
      ids = doc['login']
      url_people = BASE_URL + "users/" + ids + "?client_id=e24305f14f7f9a67c465&client_secret=604015f905f6207ec29f3661b952397663d58347"
      @results << JSON.parse(open(url_people).read)
    end

    # @repo["id"].each do |id|
    #   p id["login"]
    # end

    # @repo.each_with_index do |nb|
    #   p @repo[index]["id"]
    # end

  end

  # GET /repos/new
  def new
    # user= params[:user]
    repo= @repo.user

    url = BASE_URL + "repos/" + user + "/" + name + "/collaborators"
    # url = BASE_URL + "repos/rails/rails/collaborators"
    # url = BASE_URL + "repositories"
    @repo = JSON.parse(open(url).read)
  end

  # GET /repos/1/edit
  def edit
  end

  # POST /repos
  # POST /repos.json
  def create
    #@repo = Repo.new(repo_params)

    user= params[:user]
    repo= params[:repos]

    url = BASE_URL + "repos/" + user + "/" + repo + "/collaborators"
    # url = BASE_URL + "repos/rails/rails/collaborators"
    # url = BASE_URL + "repositories"
    @repo = JSON.parse(open(url).read)

    # respond_to do |format|
    #   if @repo.save
    #     format.html { redirect_to @repo, notice: 'Repo was successfully created.' }
    #     format.json { render action: 'show', status: :created, location: @repo }
    #   else
    #     format.html { render action: 'new' }
    #     format.json { render json: @repo.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /repos/1
  # PATCH/PUT /repos/1.json
  def update
    respond_to do |format|
      if @repo.update(repo_params)
        format.html { redirect_to @repo, notice: 'Repo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @repo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repos/1
  # DELETE /repos/1.json
  def destroy
    @repo.destroy
    respond_to do |format|
      format.html { redirect_to repos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repo
      @repo = Repo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def repo_params
      params.require(:repo).permit(:name, :user_id)
    end
end
