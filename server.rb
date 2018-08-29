require "sinatra"
require "sinatra/json"
require "./calculator_skill"
require "clova-speech"

class Server < Sinatra::Base
  def self.clova
    @clova ||= begin
      clova = Clova::Client.new

      clova.configure do |config|
        config.application_id = 'com.example.isaiah_test'
        config.skill_class = CalculatorSkill
      end

      clova
    end
  end

  def clova
    self.class.clova
  end

  #sample root page
  #
  get '/' do
    content_type 'text/plain'
    'root'
  end

  post '/post' do
    #returns a ready-to-send JSON string of the Clova request
    clova.build_response(request)
  end
end