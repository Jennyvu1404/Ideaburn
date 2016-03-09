class User::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
   def new
     super
     @user = User.new
   end

  # POST /resource
  def create
    super
    if current_user.present?
      if current_user.user_type == 2
        entrepreneur = Entrepreneur.new(entrepreneur_params)
        current_user.entrepreneur = entrepreneur
      elsif current_user.user_type == 3
        startup = Startup.new(startup_params)
        current_user.startup = startup
      elsif current_user.user_type == 4
        investor = Investor.new(investor_params)
        current_user.investor = investor
      end
      current_user.save!
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
     devise_parameter_sanitizer.for(:sign_up) << [:user_type, :username, :country, :city]
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  #def after_sign_up_path_for(resource)
  #  super(resource)
  #end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private

  def startup_params
    params[:user][:startup].permit(:name, :founded, :bussines_category, :website, :strength, :mission, :work, :register_under)
  end

  def entrepreneur_params
    params[:user][:entrepreneur].permit(:first_name, :last_name, :age, :dob, :gender, :entrepreneur_type)
  end

  def investor_params
    params[:user][:investor].permit(:name, :founded, :category, :website, :mission, :work, :register_under)
  end
end
