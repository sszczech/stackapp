require 'spec_helper'

describe Container do
  describe ".create" do
    context "creates a container" do
      subject { create(:container) }
      it {
        expect {
          subject
        }.to change(Container, :count).by(1)
      }
    end
    context "can't create a containt without a name" do
      subject { build(:container, :name => nil) }
      it {
        expect {
          subject.save
          subject.should have(1).errors_on(:name)
        }.to_not change(Container, :count).by(1)
      }
    end
  end
end
