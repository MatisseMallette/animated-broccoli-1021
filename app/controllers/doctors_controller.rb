class DoctorsController < ApplicationController 
  def show 
    @doctor = Doctor.find(params[:id])
  end

  # def destroy 
  #   doctor_patient = DoctorPatient.find(doctor_params[:merchant_id])
  #   doctor_patient.destroy
  #   redirect_to "/doctors/#{doctor_params[:id]}"
  # end

private 

  def doctor_params 
    params.require(:doctor).permit(:id)
  end
end