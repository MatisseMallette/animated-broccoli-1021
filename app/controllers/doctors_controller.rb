class DoctorsController < ApplicationController 
  def show 
    # couldn't figure out how to make this work w stronger params
    @doctor = Doctor.find(params[:id])
  end

private 

  def doctor_params 
    params.require(:doctor).permit(:id)
  end
end