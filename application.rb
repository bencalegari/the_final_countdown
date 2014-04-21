require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require File.join(File.dirname(__FILE__), 'environment')
require 'sinatra/cross_origin'
require 'pry'
require 'wolfram-alpha'
require File.join(File.dirname(__FILE__), 'env_variables')
require 'active_support/core_ext/integer/time'
require 'active_support/core_ext/numeric/time'

configure do
  set :port, 3000
  set :views, "#{File.dirname(__FILE__)}/views"
  set :http_origin, 'http://localhost:3000'
  enable :cross_origin
  set :allow_origin, :any
  set :allow_methods, [:get, :post, :options]
  set :allow_credentials, true
end

error do
  e = request.env['sinatra.error']
  Kernel.puts e.backtrace.join("\n")
  'Application error'
end

helpers do
  # add your helpers here
end

get '/' do
  cross_origin
  if params.any?
    search = WFASearch.new(params)
    @bac = search.bac
    @countdown = search.countdown
    @countdown_to = search.countdown_to
  end

  haml :root
end

class WFASearch
  attr_accessor :bac, :countdown

  def initialize(params)
    client = WolframAlpha::Client.new ENV['WA_API_KEY'], {'format' => 'plaintext'}
    query_string = "BAC #{params[:drinks]} drinks #{params[:hours]} hours #{params[:sex].downcase} #{params[:weight]} lb"
    results = client.query(query_string).pods[1].subpods[0].plaintext.split(/\r?\n/)
    @bac = results[0].match(/\| (.+)/)[1]
    @countdown = results[2].match(/\| (.+)/)[1]
  end

  def countdown_to
    countdown_string = @countdown.split(' ')
    if countdown_string.size == 4
      (countdown_string[0].to_i.hours + countdown_string[2].to_i.minutes).from_now
    elsif countdown_string[1] == 'hours'
      countdown_string[0].to_i.hours.from_now
    else
      countdown_string[0].to_i.minutes.from_now
    end
  end
end

