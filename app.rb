require 'sinatra'
require 'logger'
require 'ddtrace'
require 'ddtrace/contrib/sinatra/tracer'

require './helper.rb'

configure do
  enable :logging
  set :logger, Logger.new(STDOUT)
end

get '/' do
  Helper.randam(logger)
  'Hello World!'
end

get '/foo' do
  redirect to('/bar'), 303
end

get '/bar' do
  'New bar place'
end

get '/goog' do
  redirect 'https://www.google.com', 'wrong place'
end

get '/p1' do
  redirect to('/p2'),302
end

get '/p2' do
  redirect to('/p3'),302
end

get '/p3' do
  redirect to('/p1'),302
end

get '/sleep' do
  sleep(15)
  'slept 15 sec.'
end

get '/memory' do
  Helper.memory_leak(logger)
  "memory test done."
end

get '/cpu' do
  Helper.cpu(logger)
  "cpu test done."
end

not_found do
  'This is nowhere to be found.'
end