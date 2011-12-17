require 'spec_helper'

describe Attachment do
  describe ".create" do
    context "uploads file for post" do
      subject { build(:post) }
      it {
        expect {
          file = File.open("#{Rails.root}/test/fixtures/photo.png")
          subject.attachments.build(:file => file)
          subject.save
        }.to change(Attachment, :count).by(1)
      }
    end
  end
end
