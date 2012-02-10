# encoding: utf-8
require 'spec_helper'

describe "Teams" do

  let(:user)  { create(:user) }
  let(:group) { create(:group, :teacher => user) }

  before {
    group.users << user
  }

  context "creates new team" do
    before {
      login_as user
      visit group_path(group)
    }
    it {
      click_link 'Utwórz zespół'
      current_path.should == new_group_team_path(group)
      fill_in 'team_name', :with => 'Testowy zespół'
      fill_in 'team_description', :with => 'Testowy opis'
      check 'team_user_ids_'
      click_button 'Utwórz zespół'
      page.should have_content('Edytuj zespół')
      page.should have_content('Usuń zespół')
    }
  end

  context "shows a team as a member" do
    let(:member) { create(:user) }
    let(:team)   { create(:team, :group => group) }
    before {
      group.users << member
      team.users << member
      login_as member
    }
    it {
      visit group_team_path(group, team)
      page.should have_no_content('Edytuj zespół')
      page.should have_no_content('Usuń zespół')
      visit group_path(group)
      page.should have_no_content('Utwórz zespół')
    }
  end

  context "can't show a team page when is out of the members" do
    let(:nomember) { create(:user) }
    let(:team)   { create(:team, :group => group) }
    before {
      group.users << nomember
      login_as nomember
    }
    it {
      visit group_team_path(group, team)
      page.should have_content('Nie masz dostępu')
      visit group_path(group)
      page.should have_no_content('Utwórz zespół')
    }
  end

end
