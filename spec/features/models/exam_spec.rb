require 'rails_helper'

RSpec.describe Exam, type: :model do  
  let(:exam) {create :exam}

  describe "Check relationships" do
    it {expect belong_to(:category)}
    it {expect belong_to(:user)}
    it {expect have_many(:results).dependent(:destroy)}
    it {expect accept_nested_attributes_for(:results).allow_destroy(true)}
  end

  describe "instance method" do
    start_time = Time.zone.now - 58
    before do
      # exam.status = "completed"
      exam.category.max_time = 1
      exam.start_at = start_time
    end
    # describe "#update_start_time" do      
    #   it {expect(exam.start_at).to eq start_time}
    # end

    # describe "#update_status" do      
    #   it {expect(exam.completed?).to be true}
    # end

    describe "#time_up?" do
      it "still in time" do 
        sleep 0.seconds
        expect(exam.time_up?).to be false
      end
      it "exact time" do
        sleep 2.seconds
        expect(exam.time_up?).to be true
      end
      it "out of time" do
        sleep 1.seconds
        expect(exam.time_up?).to be true
      end
    end

    # context "#time_countdown" do
    #   it "time countdown" do
    #     sleep 5.seconds
    #     expect(exam.time_countdown).to eq 55
    #   end
    # end
  end  
end
