class User < ActiveRecord::Base
  has_many :exams, dependent: :destroy

  enum level: [:normal, :admin]
end
