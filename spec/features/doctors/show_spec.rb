require 'rails_helper'

RSpec.describe 'Doctor Show Page' do 
  describe 'visiting doctor show page' do 
    before :each do 
      @hospital_1 = Hospital.create!(name: 'Mount Sinai')
      @doctor_1 = @hospital_1.doctors.create!(name: 'Doktor', specialty: 'Doktor Stuff', university: 'Harvard')
      @patient_1 = @doctor_1.patients.create!(name: 'Jeff', age: 22, hospital_id: @hospital_1.id)
      @patient_2 = @doctor_1.patients.create!(name: 'Channing', age: 40, hospital_id: @hospital_1.id)
    end

    it 'displays doctor information' do 
      visit "/doctors/#{@doctor_1.id}" 
      
      expect(page).to have_content('Doktor')
      expect(page).to have_content('Doktor Stuff')
      expect(page).to have_content('Harvard')
    end

    it 'displays doctor hospital' do 
      visit "/doctors/#{@doctor_1.id}" 
      expect(page).to have_content('Mount Sinai')
    end

    it 'displays doctor patient list' do 
      visit "/doctors/#{@doctor_1.id}" 
      expect(page).to have_content('Jeff')
      expect(page).to have_content('Channing')
    end
  end
end