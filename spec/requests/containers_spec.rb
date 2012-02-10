# encoding: utf-8
require 'spec_helper'

describe "Containers" do
  let(:group) { create(:group) }
  let(:user)  { create(:user) }

  before {
    group.users << user
    login_as user
    visit group_path(group)
  }

  describe "creates a container" do
    context "with public access" do
      it {
        page.should have_no_selector('.containers')
        click_link 'Dodaj pojemnik'
        fill_in 'container_name', :with => 'Pojemnik testowy'
        choose 'container_access_public'
        click_button 'Utwórz pojemnik'
        visit group_path(group)
        within '.containers' do
          page.should have_selector('.container', :count => 1)
          within '.container:first' do
            page.should have_content('Pojemnik testowy')
          end
        end
      }
    end

    context "with private access" do
      it {
        page.should have_no_selector('.containers')
        click_link 'Dodaj pojemnik'
        fill_in 'container_name', :with => 'Pojemnik testowy'
        choose 'container_access_private'
        click_button 'Utwórz pojemnik'
        visit group_path(group)
        within '.containers' do
          page.should have_selector('.container', :count => 1)
          within '.container:first' do
            page.should have_content('Pojemnik testowy')
            page.should have_content('(prywatny)')
          end
        end
      }
    end
  end

  describe "containers list" do
    before {
      create(:container, :group => group, :access => 'public', :name => 'Pub1', :owner => user)
      create(:container, :group => group, :access => 'private', :name => 'Priv1')
      create(:container, :group => group, :access => 'public', :name => 'Pub2', :owner => user)
      create(:container, :group => group, :access => 'private', :name => 'Priv2')
    }

    context "see as a teacher" do
      it {
        logout
        group.users << group.teacher
        login_as group.teacher
        visit group_path(group)
        within '.containers' do
          page.should have_selector('.container', :count => 4)
          ['Pub1', 'Pub2', 'Priv1', 'Priv2'].each { |name|
            page.should have_content(name)
          }
        end
      }
    end

    context "see as a member" do
      it {
        visit group_path(group)
        within '.containers' do
          page.should have_selector('.container', :count => 2)
          page.should have_no_content('Priv1')
          page.should have_no_content('Priv2')
        end
      }
    end
  end
end
