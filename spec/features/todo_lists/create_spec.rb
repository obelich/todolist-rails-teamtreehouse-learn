require 'spec_helper'

describe "Creating todo lists" do

  it "redirect to the todo list index page on success" do
    visit todo_lists_url
    # click_link "New Todo List"
    # expect(page).to have_content('New Todo List')
  end

end