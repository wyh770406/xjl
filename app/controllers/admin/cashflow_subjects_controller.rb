module Admin
  class CashflowSubjectsController < Admin::BaseController

    def index
      @cashflow_subjects = current_user.company.cashflow_subjects.page(params[:page]).per(15)
    end

    def show
      @cashflow_subject = CashflowSubject.find(params[:id])
    end

    def new
      company_id = current_user.company.id if current_user.company
      company_id ||= 0
      @cashflow_subject = CashflowSubject.new(:company_id=>company_id)
    end

    def edit
      @cashflow_subject = CashflowSubject.find(params[:id])
    end

    def create
      @cashflow_subject = CashflowSubject.new(params[:cashflow_subject])

      if @cashflow_subject.save
        redirect_to admin_cashflow_subject_path(@cashflow_subject)
      else
        render action: "new"
      end
    end

    def update
      @cashflow_subject = CashflowSubject.find(params[:id])

      if @cashflow_subject.update_attributes(params[:cashflow_subject])
        redirect_to admin_cashflow_subject_path(@cashflow_subject)
      else
        render action: "edit"
      end
    end

    def destroy
      @cashflow_subject = CashflowSubject.find(params[:id])
      @cashflow_subject.destroy

      redirect_to admin_cashflow_subjects_url
    end
  end
end
