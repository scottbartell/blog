require 'rubygems'
require 'bundler'
Bundler.require

JEKYLL_ROOT = "jekyll/_site"

class SamSoffes < Sinatra::Base
  set :public, JEKYLL_ROOT
 
  # # This before filter ensures that your pages are only ever served once (per deploy) by Sinatra,
  # # and then by Varnish after that
  # before do
  #   response.headers['Cache-Control'] = 'public, max-age=31557600' # 1 year
  # end

  # not_found do
  #   File.read "#{JEKYLL_ROOT}/four-oh-four.html"
  # end

  get '/' do
    File.read "#{JEKYLL_ROOT}/index.html"
  end

  get %r{/posts/([a-zA-Z\-_0-9]+)/?} do
    File.read "#{JEKYLL_ROOT}/posts/#{params[:captures].first}/index.html" or not_found
  end

  get %r{/(music|about|clearance).html} do
    redirect "/#{params[:captures].first}"
  end

  get %r{/(music|about|blog|talks|archive)/?} do
    File.read "#{JEKYLL_ROOT}/#{params[:captures].first}.html"
  end
  
  get '/posts' do
    redirect '/blog'
  end
end
