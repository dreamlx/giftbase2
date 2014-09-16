module Api
  class ScoresController < Api::BaseController
    before_filter :authenticate_user!, only: [:index, :create]
    respond_to :json
    def index
      user = User.find_by_authentication_token(params[:auth_token])
      scores = Score.where(user_id: user.id).order("created_at DESC")

      render json: {scores: scores}
    end


    def topten
      order_scores  = Score.order("number DESC").limit(10)
      scores        = Array.new
      order_scores.each do |os|
        s = Hash.new
        s["username"]  = User.find(os.user_id).username
        s["number"]    = os.number
        s["time"]      = os.created_at
        scores << s
      end
      render json: {scores: scores}
    end

    def create
      score = Score.new(params[:score])

      if score.save
        render json: {score: score} #, status: :created
      else
        render json: score.errors #, status: :unprocessable_entity
      end
    end
  end
end
