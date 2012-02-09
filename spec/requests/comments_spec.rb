# encoding: utf-8
require 'spec_helper'

describe "Comments" do

  let(:user)  { create(:user) }
  let(:group) { create(:group) }

  before { login_as user }

  context "when user is a member of the group" do
    before {
      group.users << user
      visit group_path(group)
      fill_post_in
    }
    it "creates a comment" do
      within ".post:first" do
        page.should have_no_selector('.comment')
        click_link 'Dodaj komentarz'
        fill_in 'comment_content', :with => 'Komentarz'
        click_button 'Komentuj'
        page.should have_selector('.comment', :count => 1)
      end
    end
  end

  context "when user is an owner of the comment" do
    let(:post)    { create(:post, :author => user) }
    let(:comment) { build(:comment, :author => user) }
    before {
      group.users << user
      group.posts << post
      post.comments << comment
      visit group_path(group)
    }
    it "deletes" do
      page.should have_selector('.comment', :count => 1)
      within "#comment-#{comment.id}" do
        click_link 'Usuń'
        page.driver.browser.switch_to.alert.accept
      end
      page.should have_no_selector('.comment')
    end
  end

  context "when use is not an owner of the comment" do
    let(:post)    { create(:post, :author => user) }
    let(:comment) { build(:comment) }
    before {
      group.users << user
      group.posts << post
      post.comments << comment
      visit group_path(group)
    }
    it "can't delete" do
      page.should have_selector('.comment', :count => 1)
      within "#comment-#{comment.id}" do
        page.should have_no_content('Usuń')
      end
    end
  end

end
