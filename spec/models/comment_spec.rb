require 'spec_helper'

describe Comment do
  describe ".create" do
    context "creates post comment" do
      subject {
        lambda { |params|
            create(:post).comments.create(params)
        }
      }
      let(:author) { create(:user) }

      it("with all required attributes") {
        expect {
          subject.call(:author => author, :content => Forgery(:lorem_ipsum).text)
        }.to change(Comment, :count).by(1)
      }

      it("without all required attributes") {
        expect {
          subject.call({})
        }.to_not change(Comment, :count).by(1)
      }

      it("with author only") {
        expect {
          subject.call(:author => author)
        }.to_not change(Comment, :count).by(1)
      }

      it("with content only") {
        expect {
          subject.call(:content => Forgery(:lorem_ipsum).text)
        }.to change(Comment, :count).by(1)
      }
    end
  end
end
