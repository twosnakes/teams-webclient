class TeamsController < ApplicationController

  def index
        @teams = []
    
    Unirest.get("#{ENV["API_HOST"] }/api/v1/teams.json").body.each do |team_hash|
      @team << Team.new(team_hash)
    end
    
  end

  def new

  end

  def create
        team = Unirest.post(
                            "#{ ENV["API_HOST"]}/api/v1/teams.json",
                            headers: {
                                      "Accept" => "application/json"
                                      },
                            parameters: {
                                     name: params[:name],
                                     creature: params[:creature],
                                     state: params[:state]
                                    }
                            ).body

          redirect_to "/teams/#{team["id"]}"
    
  end

  def show
     @team = Team.find(params[:id])

  end

  def edit
    @team = Team.find(params[:id])
    
  end

  def update
        team = Unirest.patch(
                            "#{ ENV["API_HOST"]}/api/v1/teams/#{params["id"]}.json",
                            headers: {
                                      "Accept" => "application/json"
                                      },
                            parameters: {
                                     name: params[:name],
                                     creature: params[:creature],
                                     state: params[:state]
                                    }
                            ).body

    redirect_to "/teams/#{team["id"]}"
  end
end
