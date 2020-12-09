require 'rails_helper'

RSpec.describe 'User Dashboard Page' do
  describe 'As a registered user' do
    before :each do
      @user = User.create!(email: "John@example.com", password: "password")
      @friend = User.create!(email: "Todd@example.com", password: "password")

      visit root_path

      fill_in :email, with: @user.email
      fill_in :password, with: @user.password

      click_button("Log In")
    end

    it "I see discover movies button, friends search bar, add friend button, and my viewing parties tab" do
      expect(current_path).to eq(dashboard_path)

      expect(page).to have_button("Discover Movies")
      expect(page).to have_button("Add Friend")
      expect(page).to have_field(:friend_email)
      expect(page).to have_content("Viewing Parties")
    end

    it "I can click on the discover movies button and be taken to that page" do
      click_button("Discover Movies")

      expect(current_path).to eq('/discover')
    end

    describe 'I enter an email into the friend search field' do
      it "The email I enter is valid and registered on the site " do
        expect(current_path).to eq(dashboard_path)

        within '.friends' do
          expect(page).to have_content("You currently have no friends")
        end

        fill_in :friend_email, with: @friend.email
        click_button 'Add Friend'

        expect(current_path).to eq(dashboard_path)

        within '.friends' do
          expect(page).to have_content(@friend.email)
        end
      end

      it "The email I enter is invalid/user does not exist" do
        expect(current_path).to eq(dashboard_path)

        fill_in :friend_email, with: 'meow'
        click_button 'Add Friend'

        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content("I'm sorry your friend cannot be found")

        within '.friends' do
          expect(page).to have_content("You currently have no friends")
        end
      end
    end

    describe "I see a section with my viewing parties" do
      before :each do
        @friend_2 = @user.friends.create!(email: "Carson@example.com", password: "password")
        @friend_3 = @user.friends.create!(email: "Charlie@example.com", password: "password")
        @friend.friends << @friend_2
        @friend.friends << @friend_3

        @party = @user.parties.create!(movie_title: "The Godfather", duration: "155", day: "2020-12-17", start_time: "13:00")

      end
      it "I see viewing parties I am hosting" do
      end

      it "I see viewing parties I was invited to" do

      end
    end
  end
end
