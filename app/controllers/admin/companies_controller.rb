module Admin
  class CompaniesController < Admin::BaseController

    def index
      @companies = Company.page(params[:page]).per(15)
    end

    def show
      @company = Company.find(params[:id])
    end

    def new
      @company = Company.new
    end

    def edit
      @company = Company.find(params[:id])
    end

    def create
      @company = Company.new(params[:company])

      if @company.save
        if current_user.company.blank?
          current_user.update_attribute(:company, @company)
        end
        redirect_to admin_company_path(@company)
      else
        render action: "new"
      end
    end

    def update
      @company = Company.find(params[:id])

      if @company.update_attributes(params[:company])
        redirect_to admin_company_path(@company)
      else
        render action: "edit"
      end
    end

    def destroy
      @company = Company.find(params[:id])
      @company.destroy

      redirect_to admin_companies_url
    end
  end
end
