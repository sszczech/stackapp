# encoding: utf-8
require 'spec_helper'

describe "Groups", :type => :request do
  let(:user) { create(:user) }
  let(:group) { create(:group) }

  before {
    login_as user
  }

  context "when user is a group member" do

    before {
      group.users << user
    }

    it "shows a group dashboard" do
      visit group_path(group)
      page.should have_content(group.name)
    end

  end

  context "when user isn't a group member" do

    it "renders forbidden page" do
      visit group_path(group)
      page.should have_content('Nie masz dostępu do tej strony.')
    end

  end
end
