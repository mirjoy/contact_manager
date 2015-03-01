require 'rails_helper'

describe 'the person view', type: :feature do

  let(:person) { Person.create(first_name: 'John', last_name: 'Doe') }

  before(:each) do
    person.phone_numbers.create(number: "555-1234")
    person.phone_numbers.create(number: "555-5678")
    person.email_addresses.create(email: 'john@email.com')
    person.email_addresses.create(email: 'john2@email.com')
    visit person_path(person)
  end

  it 'shows the phone numbers' do
    person.phone_numbers.each do |phone|
      expect(page).to have_content(phone.number)
    end
  end

  it 'has a link to add a new phone number' do
    expect(page).to have_link('Add phone number', href: new_phone_number_path(person_id: person.id))
  end


  it 'adds a new phone number' do
    page.click_link('Add phone number')
    page.fill_in('Number', with: '555-8888')
    page.click_button('Create Phone number')
    expect(current_path).to eq(person_path(person))
    expect(page).to have_content('555-8888')
  end

  it 'has links to edit phone numbers' do
    person.phone_numbers.each do |phone|
      expect(page).to have_link('edit', href: edit_phone_number_path(phone))
    end
  end

  it 'edits a phone number' do
    phone = person.phone_numbers.first
    old_number = phone.number

    first(:link, 'edit').click
    page.fill_in('Number', with: '555-9191')
    page.click_button('Update Phone number')
    expect(current_path).to eq(person_path(person))
    expect(page).to have_content('555-9191')
    expect(page).to_not have_content(old_number)
  end


  it 'shows the emails' do
    person.email_addresses.each do |email|
      expect(page).to have_content(email.email)
    end
  end

  it 'has a link to add a new email' do
    expect(page).to have_link('Add an email address', href: new_email_address_path(person_id: person.id))
  end


  it 'adds a new email' do
    page.click_link_or_button('Add an email address')
    page.fill_in('Email', with: 'name@email.com')
    page.click_button('Create Email address')
    expect(current_path).to eq(person_path(person))
    expect(page).to have_content('name@email.com')
  end

  it 'has links to edit emails' do
    person.email_addresses.each do |email|
      expect(page).to have_link('edit', href: edit_email_address_path(email))
    end
  end

  xit 'edits an email' do
    emails = person.email_addresses.first
    old_email = emails.email

    within(".emailclick") do
      click_on_link_or_button('edit').first
    end
    page.fill_in('Email', with: 'name1@email.com')
    page.click_button('Update Email address')
    expect(current_path).to eq(person_path(person))
    expect(page).to have_content('name1@email.com')
    expect(page).to_not have_content(old_email)
  end

end
