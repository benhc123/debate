require 'rails_helper'

feature 'Delegations form', :devise do

  scenario 'add new delegation entry', :js do
    visit new_delegation_path
    expect(page).to have_content 'New delegation'

    expect(page).to have_css('.delegation-entry', count: 1)
    click_link 'Add Delegate'
    expect(page).to have_css('.delegation-entry', count: 2)
  end

end
