require 'eventmachine'
require 'nokogiri'

class FightStatsController < ApplicationController
  def index
    @fight = Fight.new
  end

  def show
    render text: params.inspect
  end

  def create
    if params[:fight].nil?
      flash[:alert] = "Fight doesn't exists!"
    else
      @fight = Fight.new(params[:fight])

      if @fight.valid?
        EM.run {
          http = EM::HttpRequest.new(@fight.url + '/0/').get :redirects => 0
          http.callback {
            if http.response_header.status != 200
              flash[:alert] = "Fight doesn't exists!"
            else
              #multi = EventMachine::MultiRequest.new

              get_fight_links(@fight.url, http.response) do | key, link |
                #http = EventMachine::HttpRequest.new(url)
                #req = http.get
                #multi.add key, req
                flash[:notice] ||= []
                flash[:notice] << link
              end

              fight_id = @fight.url.split('/').last()

              redirect_to :action => 'show', :id => fight_id
              return
            end
            EM.stop
          }

          http.errback {
            flash[:alert] = "#{@fight.url}\n" + http.error
            EM.stop
          }
        }
      else
        flash[:alert] = @fight.errors.full_messages
      end
    end

    redirect_to :action => 'index'
  end

  def get_fight_links(url, contents)
    page = Nokogiri::HTML(contents)

    yield url + '/0/'

    page.css('.pagescroll a').each_with_index { |link, key|
      yield url + '/' + (key + 1).to_s + '/'
    }
  end
end
