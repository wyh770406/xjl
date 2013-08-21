module Admin
  class UsersController < Admin::BaseController
    before_filter :ignore_password, only: [:update]
    before_filter :find_user, only: [:show, :edit, :update, :destroy]
    before_filter :find_companies, only: [:new, :create, :edit, :update]
    before_filter :check_params, only: [:create, :update]

    def index
      @users = current_user.is?(:admin) ? User : current_company.users
      @q = @users.search(params[:q])
      @users = @q.result.page(params[:page]).per(15)
    end

    def show
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(params[:user])

      if @user.save
        redirect_to admin_users_url
      else
        render action: "new"
      end
    end

    def edit
    end

    def update
      puts params[:user]
      if @user.update_attributes(params[:user])
        redirect_to admin_user_path(@user)
      else
        render action: "edit"
      end
    end

    def destroy
      @user.destroy

      redirect_to admin_users_url
    end

    protected

    def find_user
      @user = if current_user.is?(:admin)
        User.find(params[:id])
      else
        current_company.users.find(params[:id])
      end
    end

    def find_companies
      @companies = Company.all
    end

    def ignore_password
      if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
    end

    def check_params
      unless current_user.is?(:admin)
        params[:user][:gym_ids] = params[:user][:gym_ids].select do |gym_id|
          @gyms.map { |g| g.id.to_s }.include?(gym_id)
        end

        params[:user][:roles] = ['manager']

        params[:user][:company_id] = current_company.id
      end
    end
  end
end
