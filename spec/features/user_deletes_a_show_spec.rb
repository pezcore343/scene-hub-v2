require 'rails_helper'

# ### As a musician
#   I want to be able to delete shows I've posted
#   So I can remove shows that are cancelled

# #### Acceptance Criteria
# - [ ] Click on a Delete Show button should show a confirmation dialog
# - [ ] Confirming should delete the show and redirect to the index

feature "User deletes a show" do
  it "removes the show from the index page" do
    show = create(:show)
    band = show.band
    user = band.user
    venue = show.venue

    sign_in(user)

    visit show_path(show)
    click_on "Delete show"

    expect(page).not_to have_content band.name
    expect(page).to have_content "Show deleted!"
  end
end
