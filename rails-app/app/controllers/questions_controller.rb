require './lib/answer_question'

class QuestionsController < ApplicationController
  protect_from_forgery except: [:ask_question]

  def ask_question
    question = Question.find_by(question: ask_question_params)
    unless question
      question = Question.new(question: ask_question_params)
      question.answer, question.context = answer_question(question.question)
      question.save
      render json: question
    else
      question.ask_count += 1
      question.save
      render json: question
    end
  end

  def feel_luck
  end

  private
    def ask_question_params
      params.require(:question)
    end
end
