# setup bundler
require 'rubygems'
require 'bundler'

Bundler.require

# require sintara/base for modular mode
require 'sinatra/base'
require 'sinatra/json' # is required for rest apis
require 'sinatra/reloader'

# application root path
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

# require framework core files
require_all APP_ROOT.join('core')
require APP_ROOT.join('app.rb')

# require application structer
require_all  APP_ROOT.join('app'), APP_ROOT.join('lib'), APP_ROOT.join('config')