require 'spec_helper'

describe Post do
  describe ".create" do
    context "with content" do
      subject { create(:post) }
      it {
        expect { subject }.to change(Post, :count).by(1)
      }
    end

    context "without content" do
      subject { build(:post, :content => nil) }
      it {
        expect { subject.save }.to_not change(Post, :count).by(1)
      }
    end
  end
end
