class Exam < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :results, dependent: :destroy

  before_create :create_default_status
  after_create :create_results
  before_update :sum_correct, :update_status_completed, if: :testing?

  accepts_nested_attributes_for :results, allow_destroy: true

  scope :order_created, ->{order created_at: :desc}
  scope :other_exam, ->exam_id{where.not id: exam_id}

  enum status: [:created, :testing, :completed]

  def time_up?
    execute_time >= max_time
  end

  def update_start_time time
    update_attributes start_at: time
  end

  def update_status status
    update_attributes status: status
  end

  def time_countdown
    max_time - execute_time
  end

  def update_status_completed
    if time_up?
      self.update_status :completed
      ResultMailer.result_exam(self).deliver_now
    end
  end
  
  private
  def sum_correct
    mark = results.select do |result|
      result.answer.correct? unless result.answer.nil?
    end.count
    self.mark = "#{mark.to_s}/#{category.max_question}"
  end

  def create_default_status
    self.status = :created
  end

  def create_results
    @questions = category.questions.random_questions category.max_question
    @questions.each {|question| results.create question: question}
  end

  def execute_time
    (Time.zone.now - self.start_at).to_i
  end

  def max_time
    self.category.max_time * 60
  end
  
  def self.send_alert_mail
    @exams = Exam.all
    @exams.each do |exam|
      diff_time = (Time.now - exam.created_at)/Settings.seconds_per_minute
      if exam.created? && diff_time >= Settings.dead_time
        AlertMailer.alert_exam(exam).deliver_now
      end
    end
  end

  def self.delete_fake_exam
    current_time = Time.now
    @exams = Exam.all
    @exams.each do |exam|
      if exam.created? && exam.created_at < current_time.days_ago(Settings.number_days)
        exam.destroy
      end
    end
  end
end
