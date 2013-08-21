class Admin::BaseController < ApplicationController
  before_filter :authenticate_user!, :check_role
  authorize_resource
  layout 'admin'

  def check_role
    unless current_user.backend?
      redirect_to root_path
    end
  end

end
