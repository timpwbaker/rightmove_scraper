class AgentsController < ApplicationController
  def index
    @agents = area.agents_hash
  end

  private

  def area
    @_area ||=
      Area.find(area_id)
  end

  def area_id
    params[:area_id]
  end
end
