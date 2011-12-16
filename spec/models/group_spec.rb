require 'spec_helper'

describe Group do
  describe ".create" do
    context "creates group with set name and teacher attributes" do
      subject { create(:group) }
      it {
        expect { subject }.to change(Group, :count).by(1)
      }
    end

    context "can't create group without name and teacher" do
      subject { build(:group, :name => nil, :teacher => nil) }
      it {
        expect { subject.save }.to_not change(Group, :count).by(1)
      }
    end
  end
end
