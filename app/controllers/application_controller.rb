
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/articles/new' do
    erb :new
  end

  post '/articles' do
    @article = Article.create(params)
    redirect to "/articles/#{@article.id}"
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/:id/edit' do
    find_article
    erb :edit
  end

  get '/articles/:id' do
    find_article
    erb :show
  end

  patch '/articles/:id' do
    @article = Article.find(params[:id])
    new_params = {}
    new_params[:title] = params[:title]
    new_params[:content] = params[:content]
    @article.update(new_params)
    redirect to "/articles/#{@article.id}"
  end

  delete '/articles/:id' do
    find_article
    @article.destroy
    erb :index
  end

  def find_article
    @article = Article.find(params[:id])
  end


end
