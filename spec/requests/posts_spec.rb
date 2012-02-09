# encoding: utf-8
require 'spec_helper'

describe "Posts" do
  let(:group) { create(:group) }
  let(:user)  { create(:user) }

  before {
    login_as user
    group.users << user
    visit group_path(group)
  }

  context "user creates post" do
    it {
      current_path.should == group_path(group)
      page.should have_no_selector('.post')
      fill_post_in 'To jest przyklad'
      page.should have_selector('.post', :count => 1)
      within '.post:first' do
        within('.content') { page.should have_content('To jest przyklad') }
        within '.timestamps' do
          page.should have_content('Edytuj')
          page.should have_content('Usuń')
        end
      end
    }
  end

  context "user edit his own post" do
    before {
      group.posts << build(:post, :author => user, :content => 'X')
    }
    it {
      visit group_path(group)
      current_path.should == group_path(group)
      page.should have_selector('.post', :count => 1)
      within '.post:first' do
        within '.content' do
          page.should have_content('X')
        end
        within '.timestamps' do
          click_link 'Edytuj'
        end
      end
      fill_in 'post_content', :with => 'Y'
      click_button 'Publikuj'
      current_path.should == group_path(group)
      within '.post:first' do
        within '.content' do
          page.should have_content('Y')
        end
      end
    }
  end

  context "user delete his own post" do
    before {
      group.posts << create(:post, :author => user, :content => 'X')
    }
    it {
      visit group_path(group)
      current_path.should == group_path(group)
      page.should have_selector('.post', :count => 1)
      within '.post:first' do
        within '.timestamps' do
          click_link 'Usuń'
          page.driver.browser.switch_to.alert.accept
        end
      end
      page.should have_no_selector('.post')
      current_path.should == group_path(group)
    }
  end

  context "user can't edit or delete someone else's post" do
    before {
      group.posts << create(:post, :content => 'X')
    }
    it {
      visit group_path(group)
      current_path.should == group_path(group)
      page.should have_selector('.post', :count => 1)
      within '.post:first' do
        page.should have_no_content('Edytuj')
        page.should have_no_content('Usuń')
      end
    }
  end
end
