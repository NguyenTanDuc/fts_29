class Admin::QuestionsController < ApplicationController
  load_and_authorize_resource

  def index
    @questions = @questions.paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @answer_form = AnswerForm.new
    @categories = Category.all
    # Settings.answer_num.times {@question.answers.build}
  end

  def create
    @answer_form = AnswerForm.new answer_form_params
    if @answer_form.new_question
      flash[:success] = t :create_sucess
      redirect_to admin_questions_path
    else
      @categories = Category.all
      render :new
    end    
  end

  def edit
    @categories = Category.all
  end

  def update
    if @question.update_attributes question_params
      flash[:success] = t :update_success
      redirect_to admin_questions_path
    else
      @categories = Category.all
      render :edit
    end
  end

  def destroy
    if @question.destroy
      flash[:success] = t :delete_success
    else
      flash[:danger] = t :delete_fail
    end
    redirect_to admin_questions_path
  end

  private
  def answer_form_params
    params.require(:answer_form).permit :content, :category_id, :answer_content, :correct
  end
end
