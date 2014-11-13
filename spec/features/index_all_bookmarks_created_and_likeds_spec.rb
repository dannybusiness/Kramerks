require 'rails_helper'

# As a user,
# I want to see a list of bookmarks on my personal index that I've
# added to Kramerks, in addition to bookmarks that I've liked from other users.
# so that I can see the most relevant bookmarks to me.

feature "index_all_bookmarks_created_and_liked" do

  scenario " " do
    user1 = create(:user, email: "user1@test.com")
    user2 = create(:user, email: "user2@test.com")

    
    login_as user1.email, user1.password
    create_bookmark("user1 bookmark", "www.test1.com", "tag1")
    visit root_path
    within('button#logout')do 
        click_on "Logout"
    end
    login_as user2.email, user2.password
    create_bookmark("user2 bookmark", "www.test2.com", "tag2")

    visit bookmarks_path
    click_on "user1 bookmark"
    click_on "Favorite"

    visit bookmarks_path

    click_on "My Kramerks"

    expect(page).to have_content("user1 bookmark")
    expect(page).to have_content("user2 bookmark")


  end

  def create_bookmark(title, url, tags)
    visit bookmarks_path
    click_link 'New Bookmark'
    fill_in 'Title', with: title
    fill_in 'Url', with: url
    fill_in 'Tags (separated by commas)', with: tags 
    click_button 'Create Bookmark'
  end

  def login_as username,password
    visit root_path
    within('button#login') do
        click_on('Login')
    end
    fill_in "Email", with: username
    fill_in "Password", with: password
    click_on "Sign in"
  end
end
