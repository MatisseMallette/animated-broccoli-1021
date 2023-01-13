require 'rails_helper'

RSpec.describe 'Patient Index Page' do 
  describe 'visiting patient index page' do 
    before :each do 
      @hospital_1 = Hospital.create!(name: 'Mount Sinai')
      
      @doctor_1 = @hospital_1.doctors.create!(name: 'Doktor', specialty: 'Doktor Stuff', university: 'Harvard')
      @doctor_2 = @hospital_1.doctors.create!(name: 'Rotkod', specialty: 'Other Stuff', university: 'Yale')

      @patient_1 = @doctor_1.patients.create!(name: 'Jeff', age: 22, hospital_id: @hospital_1.id)
      @patient_2 = @doctor_1.patients.create!(name: 'Channing', age: 40, hospital_id: @hospital_1.id)
      @patient_3 = @doctor_1.patients.create!(name: 'Bob', age: 17, hospital_id: @hospital_1.id)
      
      @doctor_patient_1 = DoctorPatient.create(doctor_id: @doctor_2.id, patient_id: @patient_1.id)
    end

    it 'displays patients' do 
      visit '/patients'
      binding.pry
      expect(page).to have_content(@patient_1.name)
      expect(page).to have_content(@patient_2.name)
      expect(page).to_not have_content(@patient_3.name)
    end
  end
end