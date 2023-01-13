require 'rails_helper'

RSpec.describe 'Doctor Show Page' do 
  describe 'visiting doctor show page' do 
    before :each do 
      @hospital_1 = Hospital.create!(name: 'Mount Sinai')
      
      @doctor_1 = @hospital_1.doctors.create!(name: 'Doktor', specialty: 'Doktor Stuff', university: 'Harvard')
      @doctor_2 = @hospital_1.doctors.create!(name: 'Rotkod', specialty: 'Other Stuff', university: 'Yale')

      @patient_1 = @doctor_1.patients.create!(name: 'Jeff', age: 22, hospital_id: @hospital_1.id)
      @patient_2 = @doctor_1.patients.create!(name: 'Channing', age: 40, hospital_id: @hospital_1.id)

      @doctor_patient_1 = DoctorPatient.create(doctor_id: @doctor_2.id, patient_id: @patient_1.id)
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

    it 'displays patient delete buttons' do 
      visit "/doctors/#{@doctor_1.id}" 
      
      within("#patient_#{@patient_1.id}") do
        expect(page).to have_button('remove')
      end

      within("#patient_#{@patient_2.id}") do
        expect(page).to have_button('remove')
      end
    end

    it 'destroys doctor patient relationship upon clicking remove button' do 
      visit "/doctors/#{@doctor_1.id}" 
      
      # save_and_open_page

      expect(page).to have_content(@patient_1.name)

      click_button('remove', id: @patient_1.id)

      # save_and_open_page

      expect(current_path).to eq("/doctors/#{@doctor_1.id}")

      expect(page).to_not have_content(@patient_1.name)

      expect(page).to have_content(@patient_2.name)
    end

    it 'still displays patient on doctor show pages they have not been removed from' do 
      visit "/doctors/#{@doctor_1.id}" 
      click_button('remove', id: @patient_1.id)
      expect(page).to_not have_content(@patient_1.name)
      visit "/doctors/#{@doctor_2.id}" 
      expect(page).to have_content(@patient_1.name)
    end
  end
end