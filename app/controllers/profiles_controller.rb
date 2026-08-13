class ProfilesController < ApplicationController

  def show
    @hospital = Hospital.find(params[:hospital_id])
    @profile = @hospital.profile
  end

  def new
    @hospital =  Hospital.find(params[:hospital_id])

    if @hospital.profile.present?
      redirect_to hospital_profile_path(@hospital),
                  notice: "Profile already exists"
    else
      @profile = @hospital.build_profile
    end
  end


def create
  @hospital =  Hospital.find(params[:hospital_id])

  @profile = @hospital.build_profile(profile_params)

  if @profile.save
    redirect_to hospital_path(@hospital, mode: "profile_card"),
                notice: "Profile created successfully"
  else
    @mode = "profile_form"
    render "hospitals/show", status: :unprocessable_entity
  end
end
  

  def edit
    @hospital =  Hospital.find(params[:hospital_id])
    @profile = @hospital.profile
  end

 def update
  @hospital =  Hospital.find(params[:hospital_id])
  @profile = @hospital.profile

  if @profile.update(profile_params)
    redirect_to hospital_path(@hospital, mode: "profile_card"),
                notice: "Profile updated successfully"
  else
    render :edit, status: :unprocessable_entity
  end
end
  def destroy
    @hospital = Hospital.find(params[:hospital_id])
    @profile = @hospital.profile

    @profile.destroy

   redirect_to hospital_path(@hospital, mode: "profile_card"),
            notice: "Profile deleted successfully"
  end

  private

  def profile_params
    params.require(:profile)
          .permit(:bio, :address, :phone)
  end

end