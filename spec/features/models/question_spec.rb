require 'rails_helper'

describe Question do
  let(:question){create :question}
  subject {question}
  describe "check relationship" do
    it {expect have_many(:answers).dependent(:destroy)}
    it {expect have_many(:results).dependent(:destroy)}
    it {expect belong_to(:category).dependent(:destroy)}
    it {expect accept_nested_attributes_for(:answers).allow_destroy(true)}
  end
end
