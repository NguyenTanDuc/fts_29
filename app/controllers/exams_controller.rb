class ExamsController < ApplicationController
  load_and_authorize_resource
  before_action :check_only_one_test, only: :edit

  def index
    @exam = Exam.new
    @categories = Category.all
    @exams = @exams.order_created.paginate page: params[:page], per_page: Settings.per_page    
  end

  def show
  end

  def create
    @exam.user = current_user
    if @exam.save
      flash[:success] = t :create_success
    else
      flash[:danger] = t :create_fail
    end
    redirect_to root_path
  end

  def edit
    if @exam.created?
      @exam.update_start_time Time.zone.now 
      @exam.update_status :testing
    elsif @exam.completed?
      redirect_to exam_path(@exam)
    end
  end

  def update    
    if !params[:complete].nil?
      @exam.update_status_completed
      respond_to do |format|
        format.js
      end 
    else
      if @exam.update_attributes exam_params
        flash[:success] = t :update_success      
      else
        flash[:danger] = t :update_fail
      end
      redirect_to root_path
    end    
  end

  private  
  def exam_params
    params.require(:exam).permit :category_id, results_attributes: [:id, :answer_id]
  end

  def check_only_one_test
    if current_user.exams.other_exam(@exam.id).testing.count > 0
      flash[:danger] = t :only_test
      redirect_to root_path
    end
  end
end
