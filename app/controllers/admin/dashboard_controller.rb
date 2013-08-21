module Admin
  class DashboardController < Admin::BaseController
    skip_authorize_resource
    authorize_resource class: false

    def index
    	if current_user.is?("admin")
        redirect_to admin_users_path
      elsif current_user.is?("accountant")
      	redirect_to admin_cashflow_subjects_path
      end
    end

  end
end
