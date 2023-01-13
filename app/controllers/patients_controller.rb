class PatientsController < ApplicationController 
  def index 
    # couldn't figure out how to make this work w stronger params
    @patients = Patient.patients_over_age(18)
  end
end