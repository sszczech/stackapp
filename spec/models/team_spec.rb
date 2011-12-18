require 'spec_helper'

describe Team do
  describe ".create" do
    context "creates a team with name" do
      subject { create(:team) }
      it {
        expect {
          subject
        }.to change(Team, :count).by(1)
      }
    end

    context "can't create a team without name" do
      subject { build(:team, :name => nil) }
      it {
        expect {
          subject.save
          subject.should have(1).errors_on(:name)
        }.to_not change(Team, :count).by(1)
      }
    end
  end
end
