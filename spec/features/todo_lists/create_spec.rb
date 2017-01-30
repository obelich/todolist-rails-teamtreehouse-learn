require 'spec_helper'

describe "Creating todo lists" do



  it "redirect to the todo list index page on success" do
    visit "todo_lists" # Entrar a una URL
    click_link "New Todo List" # Hacer click en un enlace con contenga el nombre
    expect(page).to have_content('New Todo List')  # Se espera que en el documento se encuentre el siguiente texto

    fill_in "Title", with: "My todo List" # Se llena un input con el name title
    fill_in "Description", with: "This is what I`m doing today" # Se llena input con el name Description
    click_button "Create Todo list" # Se da click en el boton de submit

    expect(page).to have_content('My todo List')
  end

  it "Display an error when the todo list has no title" do
    expect(TodoList.count).to eq(0)
    visit "todo_lists" # Entrar a una URL
    click_link "New Todo List" # Hacer click en un enlace con contenga el nombre
    fill_in "Title", with: ""
    fill_in "Description", with: "This is what I`m doing today" # Se llena input con el name Description
    click_button "Create Todo list" # Se da click en el boton de submit

    expect(page).to have_content('error')
    expect(TodoList.count).to eq(0)

    visit "todo_lists"
    expect(page).to_not have_content('This is what I`m doing today') # Aquí se espera que no contenga este texto en la pagina

  end

  it "Display an error when the todo list has a title less than 3 characters" do
    expect(TodoList.count).to eq(0)
    visit "todo_lists" # Entrar a una URL
    click_link "New Todo List" # Hacer click en un enlace con contenga el nombre
    fill_in "Title", with: "Hi"
    fill_in "Description", with: "This is what I`m doing today" # Se llena input con el name Description
    click_button "Create Todo list" # Se da click en el boton de submit

    expect(page).to have_content('error')
    expect(TodoList.count).to eq(0)

    visit "todo_lists"
    expect(page).to_not have_content('This is what I`m doing today')

  end



  it "Display an error when the todo list has no description" do
    expect(TodoList.count).to eq(0)
    visit "todo_lists" # Entrar a una URL
    click_link "New Todo List" # Hacer click en un enlace con contenga el nombre
    fill_in "Title", with: "Grosery List"
    fill_in "Description", with: "" # Se deja el contenido en blanco
    click_button "Create Todo list" # Se da click en el boton de submit

    expect(page).to have_content('error')
    expect(TodoList.count).to eq(0)

    visit "todo_lists"
    expect(page).to_not have_content('Grosery List')

  end

  it "Display an error when the todo list has description less than 5 characters" do
    expect(TodoList.count).to eq(0)
    visit "todo_lists" # Entrar a una URL
    click_link "New Todo List" # Hacer click en un enlace con contenga el nombre
    fill_in "Title", with: "Grosery List"
    fill_in "Description", with: "food" # Se deja el contenido en blanco
    click_button "Create Todo list" # Se da click en el boton de submit

    expect(page).to have_content('error')
    expect(TodoList.count).to eq(0)

    visit "todo_lists"
    expect(page).to_not have_content('Grosery List')

  end

end