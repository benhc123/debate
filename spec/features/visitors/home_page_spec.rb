# Feature: Home page
#   As a visitor
#   I want to visit a home page
#   So I can learn more about the website
feature 'Home page' do

  scenario 'visit the home page' do
    visit root_path
    expect(page.status_code).to eq 200
  end

end
