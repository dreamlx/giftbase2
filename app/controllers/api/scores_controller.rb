module Api
  class ScoresController < Api::BaseController
    before_filter :authenticate_user!, only: [:index, :create]
    respond_to :json
    def index
      user = User.find_by_authentication_token(params[:auth_token])
      scores = Score.where(user_id: user.id).order("created_at DESC")

      render json: {scores: scores, error: 1, msg: "succeed"}
    end


    def topten
      user_ids  = Score.order("number DESC").uniq.pluck(:user_id).first(10)
      scores        = Array.new
      user_ids.each do |user_id|
        s = Hash.new
        s["username"]  = User.find(user_id).username
        s["number"]    = Score.order("number DESC").find_by_user_id(user_id).number
        s["time"]      = Score.order("number DESC").find_by_user_id(user_id).created_at
        scores << s
      end
      render json: {scores: scores, error: 1, msg: "succeed"}
    end

    def create
      score = Score.new(params[:score])

      if score.save
        render json: {score: score, error: 1, msg: "succeed"} #, status: :created
      else
        render json: {error: 0, msg: format_error_message(score.errors) } #, status: :unprocessable_entity
      end
    end
  end
end
