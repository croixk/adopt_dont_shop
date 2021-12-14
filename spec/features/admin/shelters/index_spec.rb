require 'rails_helper'

RSpec.describe 'shelter index ' do

  it 'index view' do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    visit '/admin/shelters'
    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_content(@shelter_3.name)
    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@shelter_1.name)

  end

  it 'can show pending applications' do

    @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_2.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_2.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    @application_1 = Application.create!(name: 'Joe', address: '5555 Pine St', city: 'Boulder', state: 'Colorado', zip: '80304', description: 'Dog lover', status: 'Pending')
    @application_2 = Application.create!(name: 'John', address: '5555 Pine St', city: 'Boulder', state: 'Colorado', zip: '80304', description: 'I like animals', status: 'In Progress')

    @application_pet_1 = ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application_1.id)
    @application_pet_2 = ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application_2.id)


    visit '/admin/shelters'

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)

  end

end
