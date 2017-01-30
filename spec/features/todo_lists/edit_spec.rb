require 'spec_helper'

describe 'Editing todo list' do

  let!(:todo_list) {TodoList.create(title: "Groceries", description: "Grocery List.")} # Se hace que la variable todo_list global y accesible en cada it

  def update_todo_list(options={})
    todo_list = options[:todo_list]
    options[:title] ||= "My todo List"
    options[:description] ||= "This is what I`m doing today"

    visit "todo_lists" # Entrar a una URL
    within "#todo_list_#{todo_list.id}" do
      click_link "Edit"
    end



    fill_in "Title", with: options[:title] # Se llena un input con el name title
    fill_in "Description", with: options[:description] # Se llena input con el name Description
    click_button "Update Todo list" # Se da click en el boton de submit
  end

  it 'Update a todo list successfully wit correct information' do
    update_todo_list todo_list: todo_list, title: "New title", description: "New description"

    todo_list.reload
    expect(page).to have_content('Todo list was successfully updated.')
    expect(todo_list.title).to eq('New title')
    expect(todo_list.description).to eq('New description')
  end

  it 'display an error with no title' do
    update_todo_list todo_list: todo_list, title: "", description: "New description"
    title = todo_list.title
    todo_list.reload
    expect(todo_list.title).to eq(title)
    expect(page).to have_content('error')

  end

  it 'display an error with to short a title' do
    update_todo_list todo_list: todo_list, title: "Hi", description: "New description"
    expect(page).to have_content('error')

  end

  it 'display an error with no description' do
    update_todo_list todo_list: todo_list, title: "New title", description: ""
    expect(page).to have_content('error')

  end

  it 'display an error with no to short a description' do
    update_todo_list todo_list: todo_list, title: "New title", description: "Hi"
    expect(page).to have_content('error')

  end



end