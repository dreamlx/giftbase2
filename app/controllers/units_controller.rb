class UnitsController < ApplicationController
  before_filter :authenticate_user!
  def show
    @unit = Unit.find(params[:id])
  end
end
