# encoding: utf-8
module Helpers
  def login_as(user)
    visit root_path
    fill_in 'user_email', :with => user.email
    fill_in 'user_password', :with => user.password
    click_button 'Zaloguj się'
    current_path.should == dashboard_path
  end

  def logout
    click_link 'Wyloguj'
  end

  def fill_post_in(content = nil)
    content ||= Forgery(:lorem_ipsum).text
    fill_in 'post_content', :with => content
    click_button 'Publikuj'
  end
end