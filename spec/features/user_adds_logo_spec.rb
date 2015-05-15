require 'spec_helper'

feature 'Staff can manage logos' do
  background do
    @staff = create(:user, :staff, institution_id: 1)
    @institution = build_stubbed(Institution)
    Institution.stub(:find_by) { @institution }
    @institution.stub(:short_name) { "Metro Boston" }
    create :logo, institutions: [@institution]
    visit institution_path(@institution)
  end

  scenario 'sees first logo on main page' do
    logos = all 'img.sponsor.logo'
    expect(logos).to_not be_empty
    expect(logos).to have(1).item
  end

  scenario 'adds a logo' do
    sign_in @staff
    visit '/admin'
    expect(all '.logo_links').to_not be_empty
    first(:link, 'Logos').click
    expect(page).to have_selector('tbody tr.logo_row', count: 1)

    click_link 'Add new'
    fill_in 'Alt', with: 'A clear and present logo'
    attach_file("Image", "#{Rails.root}/spec/fixtures/files/logo.png")
  
    # save_and_open_page
    # click_link("Choose all")
    # find('ui-icon.ui-icon-circle-triangle-e.ra-multiselect-item-add').click  
    
    click_button 'Save'
    expect(page).to have_content('Logo successfully created' )
  end
end