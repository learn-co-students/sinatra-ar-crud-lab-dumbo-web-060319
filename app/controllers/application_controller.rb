require 'pry'
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base
	configure do
		set :public_folder, 'public'
		set :views, 'app/views'
	end

	get '/' do
		erb :index
	end

	get '/articles' do
		@articles = Article.all
		erb :index
	end

	get '/articles/new' do
		erb :new
	end

	get '/articles/:id' do
		@article = Article.find(params[:id])
		erb :show
	end

	get '/articles/:id/edit' do
		@article = Article.find(params[:id])
		erb :edit
	end

	post '/articles' do
		puts params
		Article.create(params)
		redirect to "articles/#{Article.all.last.id}"
	end

	patch '/articles/:id' do
		Article.find(params[:id]).update(params[:article])
		redirect to "articles/#{params[:id]}"
	end

	delete '/articles/:id' do
		Article.find(params[:id]).destroy
		redirect to './articles'
	end

end
