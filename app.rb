require 'bundler'
Bundler.setup

require 'cloudapp'
require 'sinatra'
require 'tempfile'

class S3itchApp < Sinatra::Base

  helpers do
    def protected!
      unless authorized?
        response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
        throw :halt, [ 401, 'Not authorized\n' ]
      end
    end

    def authorized?
      auth.provided? && auth.basic? && auth.credentials
    end

    def auth
      @auth ||= Rack::Auth::Basic::Request.new(request.env)
    end

    def token
      Array(auth.credentials).last
    end

    def account
      account = CloudApp::Account.using_token token
    end
  end

  get('/') do redirect('https://github.com/lmarburger/s3itch#readme', 302) end

  # Skitch expects to make a HEAD request at Base URL + filename to ensure the
  # file exists. Must fake it out.
  get('/check/:name') do 200 end

  put '/:name' do
    protected!

    extension = File.extname params[:name]
    filename  = File.basename params[:name], extension

    Tempfile.open([ filename, extension ]) do |file|
      file.write request.body.read
      file.rewind
      account.upload file, name: params[:name]
    end

    201
  end
end
