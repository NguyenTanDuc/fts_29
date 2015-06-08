require 'rails_helper'

describe Category do
  let(:category) {create(:category)}
  subject {category}
  describe "check relationship" do
    it {expect have_many(:exams).dependent(:destroy)}
    it {expect have_many(:questions).dependent(:destroy)}
  end

  describe "validation" do
    describe "presence" do
      before do
        category.name = nil
        category.max_question = nil
        category.max_time = nil
      end
      describe "#name should be presence" do
        it {is_expected.to have(2).error_on(:name)}
      end

      describe "#max_question should be presence" do
        it {is_expected.to have(2).error_on(:max_question)}
      end

      describe "#max_time should be presence" do
        it {is_expected.to have(2).error_on(:max_time)}
      end
    end

    describe "data type" do
      before do
        category.max_question = "abc"
        category.max_time = "cba"
      end

      describe "#max_question should be numberic" do
        it {is_expected.to have(1).error_on(:max_question)}
      end

      describe "#max_time should be numberic" do
        it {is_expected.to have(1).error_on(:max_question)}
      end
    end

    describe "length" do
      describe "#name should not be too short" do
        before do
          category.name = "a"
        end
        it {is_expected.to have(1).error_on(:name)}
      end

      describe "#name should not be too long" do
        before do
          category.name = "a" * 51
        end
        it {is_expected.to have(1).error_on(:name)}
      end
    end

    describe "#name must be uniquesness" do
      it {expect(build(:category, name: category.name, max_question: "20", max_time: "10")).to have(1).error_on(:name)}
    end
  end
end
