require 'rails_helper'

# As a user, 
# I want to be able to sign in and out of the Kramerks application
# So I can access and manage my bookmarks.

feature 'sign in sign out' do

  scenario 'successfully' do
    user = User.new(:email => 'j@g.com', :password => 'password') 
    user.confirmed_at = Time.now
    
    visit root_path
    save_and_open_page
    click_link 'Login'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    expect(page).to have_content('Successfully logged in.')
    
    
  end
end
