module Admin
  class CashFlowsController < Admin::BaseController

    def index
      @cash_flows = current_user.company.cash_flows.page(params[:page]).per(15)
    end

    def show
      @cash_flow = CashFlow.find(params[:id])
    end

    def new
      company_id = current_user.company.id if current_user.company
      company_id ||= 0
      @cash_flow = CashFlow.new(:company_id=>company_id)
    end

    def edit
      @cash_flow = CashFlow.find(params[:id])
    end

    def create
      @cash_flow = CashFlow.new(params[:cash_flow])

      if @cash_flow.save
        redirect_to admin_cash_flow_path(@cash_flow)
      else
        render action: "new"
      end
    end

    def update
      @cash_flow = CashFlow.find(params[:id])

      if @cash_flow.update_attributes(params[:cash_flow])
        redirect_to admin_cash_flow_path(@cash_flow)
      else
        render action: "edit"
      end
    end

    def destroy
      @cash_flow = CashFlow.find(params[:id])
      @cash_flow.destroy

      redirect_to admin_cash_flows_url
    end
  end
end
