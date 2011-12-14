require 'spec_helper'

describe User do
  describe ".create" do
    context "when required attributes are set" do
      subject { create(:user) }
      it {
        expect { subject }.to change(User, :count).by(1)
      }
    end

    context "when there is no set attributes" do
      subject {
        build(:user, :email => nil, :first_name => nil,
               :last_name => nil, :password => nil)
      }
      it {
        expect { subject.save }.to_not change(User, :count).by(1)
      }
    end
  end

  describe "#name" do
    context "shows first_name and last_name" do
      subject {
        create(:user, :first_name => "Jan", :last_name => "Kowalski")
      }
      its(:name) { should == "Jan Kowalski" }
    end
  end
end
