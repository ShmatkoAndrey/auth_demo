require 'rails_helper'

describe 'social buttons facebook' do

  before {
    @fb_user = {email: 'erygjoz_laustein_1461688220@tfbnw.net', password: '456369'}
  }

  it 'works!', js: true do
    visit "http://localhost:3000#{new_sessions_path}"
    expect(page).to have_content('Hi, Guest')
  end

  it 'invalid password facebook', js: true do
    visit "http://localhost:3000#{new_sessions_path}"
    find('#fb-button').click
    sleep 5.second
    if page.driver.browser.window_handles.length == 1
      sleep 5.seconds
    end
    within_window('Facebook') do
      fill_in 'email', with: @fb_user[:email]
      fill_in 'pass', with: 'xx'
      find('#loginbutton').click
      sleep 2.second
      click_button 'Cancel'
    end
    visit 'http://localhost:3000'
    expect(page).to have_content('Hi, Guest')
  end

  it 'facebook click cancel button', js: true do
    visit "http://localhost:3000#{new_sessions_path}"
    find('#fb-button').click
    sleep 5.second
    if page.driver.browser.window_handles.length == 1
      sleep 5.seconds
    end
    within_window('Facebook') do
      click_button 'Cancel'
    end
    visit 'http://localhost:3000'
    expect(page).to have_content('Hi, Guest')
  end

  it 'new login and redirect', js: true do
    visit "http://localhost:3000#{new_sessions_path}"
    find('#fb-button').click
    sleep 5.second
    if page.driver.browser.window_handles.length == 1
      sleep 5.seconds
    end
    within_window('Facebook') do
      fill_in 'email', with: @fb_user[:email]
      fill_in 'pass', with: @fb_user[:password]
      find('#loginbutton').click
    end
    sleep 5.second
    expect(page).to have_content("Hi, #{@fb_user[:email]}")
  end

  it 'login after login and redirect', js: true do
    visit "http://localhost:3000#{new_sessions_path}"
    sleep 2.second
    find('#fb-button').click
    sleep 5.second
    visit 'http://localhost:3000'
    expect(page).to have_content("Hi, #{@fb_user[:email]}")
  end
end