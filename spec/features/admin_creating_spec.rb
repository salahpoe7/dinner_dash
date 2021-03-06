require "rails_helper"
describe "admin creating mode" do
  context "for breeds" do
    it "allows admin to create a new breed" do
      # 059
      # As an Admin
      # When I visit "/admin/breeds/:id/edit"
      # And I fill in the name field
      # And I fill in the description field
      # And I click the "save" button
      # Then I am redirected to that breed"s page
      # And I see the edited breed with it"s new name and description
      create(:user, role: 1)
      visit new_admin_breed_path

      fill_in "enter name", with: "TEst_new_name"
      fill_in "enter description", with: "test_new_description"
      fill_in "enter image_path", with: "test_new_image_path"
      fill_in "enter retired", with: true
      click_link_or_button("Create")

      within("#flash-newcomplete") do
        expect(page).to have_content("Test new name created!")
      end
      expect(current_path).to eq("/admin/breeds/test_new_name")
    end

    it "doesn't allow the admin to not fill in any fields" do
      create(:user, role: 1)
      visit new_admin_breed_path

      fill_in "enter name", with: "TEst_fail_name"
      click_link_or_button("Create")
      within("#flash-newfail") do
        expect(page).to have_content("fill every field in with a valid entry")
      end
    end
  end

  context "for individual cats" do
    it "allows admin to create a cat" do
      # 063
      # As an Admin
      # When I visit "/admin/cats/:id/edit"
      # And I fill in the name field
      # And I fill in the description field
      # And I click the "save" button
      # Then I am redirected to that cat"s page
      # And I see the edited cat with it"s new name and description
      # fill_in "edit price", with: "test-description"
      visit new_admin_cat_path

      fill_in "enter name", with: "TEst_new name"
      fill_in "enter description", with: "test_new_description"
      fill_in "enter price", with: 1000
      fill_in "enter image_path", with: "test_new_image_path"
      fill_in "enter retired", with: true
      click_link_or_button("Create")

      within("#flash-newcomplete") do
        expect(page).to have_content("Test new name created!")
      end
      cat = Cat.find_by(name: "TEst_new name")
      expect(current_path).to eq("/admin/cats/#{cat.id}")
    end

    it "changes all different types of names" do
      create(:user, role: 1)
      visit new_admin_cat_path

      fill_in "enter name", with: "Perci the cat"
      click_link_or_button("Create")
      within("#flash-newfail") do
        expect(page).to have_content("Please fill every field in with a valid")
      end
    end
  end
end
