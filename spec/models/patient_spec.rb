require 'rails_helper'

RSpec.describe Patient, type: :model do
  it {should have_many :doctor_patients}
  it {should have_many(:doctors).through(:doctor_patients)}
  it {should belong_to :hospital}

  describe 'Model methods' do 
    before :each do 
      @hospital_1 = Hospital.create!(name: 'Mount Sinai')
      
      @doctor_1 = @hospital_1.doctors.create!(name: 'Doktor', specialty: 'Doktor Stuff', university: 'Harvard')
      @doctor_2 = @hospital_1.doctors.create!(name: 'Rotkod', specialty: 'Other Stuff', university: 'Yale')

      @patient_1 = @doctor_1.patients.create!(name: 'Bab', age: 1, hospital_id: @hospital_1.id)
      @patient_2 = @doctor_1.patients.create!(name: 'Runt', age: 5, hospital_id: @hospital_1.id)
      @patient_3 = @doctor_1.patients.create!(name: 'Adult', age: 22, hospital_id: @hospital_1.id)
      @patient_4 = @doctor_1.patients.create!(name: 'Methuselah', age: 1000, hospital_id: @hospital_1.id)
    end

    it '.patients_over_age' do 

      # this method also sorts alphabetically, descending. I would have liked to make this a seperate method for clarity, but oh well. 
      expect(Patient.patients_over_age(22)).to eq([@patient_4])
      expect(Patient.patients_over_age(5)).to eq([@patient_3, @patient_4])
      expect(Patient.patients_over_age(1)).to eq([@patient_3, @patient_4, @patient_2])
      expect(Patient.patients_over_age(0)).to eq([@patient_3, @patient_1, @patient_4, @patient_2])
    end
  end 
end
