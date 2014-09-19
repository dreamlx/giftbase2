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
        scores << User.find(user_id).top_score
      end
      sort_scores = scores.sort_by {|score| score[:number]}.reverse
      render json: {scores: sort_scores, error: 1, msg: "succeed"}
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
