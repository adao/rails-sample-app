class QuestionsController < ApplicationController
  protect_from_forgery except: [:ask_question]

  def ask_question
    render json: "noooooo"
  end
end
