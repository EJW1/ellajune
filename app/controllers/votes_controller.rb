class VotesController < ApplicationController
  before_filter :authenticate_user!

  def create
    if current_user
      @vote = current_user.votes.create(params[:vote])
      respond_to do |format|
        if @vote.save
         format.html { redirect_to :back }
         format.json { render json: @vote, status: :created, location: @vote }
        else
          format.html { redirect_to :back, alert: "You already upvoted this post" }
          format.json { render json: @link.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to :back, alert: "You must sign in to vote"
    end
  end

  
end