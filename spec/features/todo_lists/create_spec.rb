require 'spec_helper'

describe "Creating todo lists" do

  # Mejoramos el script para que no se este repitiendo
  def create_todo_list(options={})
    options[:title] ||= "My todo List"
    options[:Description] ||= "This is what I`m doing today"

    visit "todo_lists" # Entrar a una URL
    click_link "New Todo List" # Hacer click en un enlace con contenga el nombre
    expect(page).to have_content('New Todo List')  # Se espera que en el documento se encuentre el siguiente texto

    fill_in "Title", with: options[:title] # Se llena un input con el name title
    fill_in "Description", with: options[:Description] # Se llena input con el name Description
    click_button "Create Todo list" # Se da click en el boton de submit
  end


  it "redirect to the todo list index page on success" do
    create_todo_list

    expect(page).to have_content('My todo List')
  end

  it "Display an error when the todo list has no title" do
    expect(TodoList.count).to eq(0)
    create_todo_list title: ""

    expect(page).to have_content('error')
    expect(TodoList.count).to eq(0)

    visit "todo_lists"
    expect(page).to_not have_content('This is what I`m doing today') # Aquí se espera que no contenga este texto en la pagina

  end

  it "Display an error when the todo list has a title less than 3 characters" do

    expect(TodoList.count).to eq(0)
    create_todo_list title: "Hi"


    expect(page).to have_content('error')
    expect(TodoList.count).to eq(0)

    visit "todo_lists"
    expect(page).to_not have_content('This is what I`m doing today')

  end



  it "Display an error when the todo list has no description" do
    expect(TodoList.count).to eq(0)

    create_todo_list title: "Grosery List", Description: ""

    expect(page).to have_content('error')
    expect(TodoList.count).to eq(0)

    visit "todo_lists"
    expect(page).to_not have_content('Grosery List')

  end

  it "Display an error when the todo list has description less than 5 characters" do
    expect(TodoList.count).to eq(0)

    create_todo_list  title: "Grosery List", Description: "food"

    expect(page).to have_content('error')
    expect(TodoList.count).to eq(0)

    visit "todo_lists"
    expect(page).to_not have_content('Grosery List')

  end

end