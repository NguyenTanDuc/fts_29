class AnswerForm 
  include ActiveModel::Model

  attr_accessor :content, :answer_content, :correct, :category_id

  validates :content, presence: true
  validates :answer_content, presence: true

  def new_question
    if valid?
      create_question
      create_answer
      true
    else
      false
    end    
  end

  private
  def create_question
    hash = {}
    hash[:content] = "#{content}"
    hash[:category_id] = "#{category_id}"
    @question ||= Question.new(hash)
    @question.save!
  end

  def create_answer
    hash = {}
    hash[:content] = "#{answer_content}"
    hash[:correct] = "#{correct}"
    @answer ||= Answer.new(hash)
    @answer.question_id = @question.id
    @answer.save!
  end
end