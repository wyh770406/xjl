module Admin
  class CashflowReportsController < Admin::BaseController

    def index
      @report_name = t("nav.settings_nav.total_reports")
      where_condition = {}
      if params[:begin_date].nil? || params[:begin_date].blank?
        begin_date = Date.parse("1111-01-01")
      else
        begin_date = Date.parse(params[:begin_date])
      end

      if params[:end_date].nil? || params[:end_date].blank?
        end_date = Date.parse("2999-12-31")
      else
        end_date = Date.parse(params[:end_date])
      end

      if params[:company_id].nil? || params[:company_id].blank?
        company_id = 0
      else
        company_id = params[:company_id].to_i
      end

      if params[:cashflow_subject_id].nil? || params[:cashflow_subject_id].blank?
        cashflow_subject_id = 0
      else
        cashflow_subject_id = params[:cashflow_subject_id].to_i
      end

      if params[:corresponding_subject_id].nil? || params[:corresponding_subject_id].blank?
        corresponding_subject_id = 0
      else
        corresponding_subject_id = params[:corresponding_subject_id].to_i
      end

      where_condition = where_condition.merge(:cashflow_date=>begin_date..end_date)
      where_condition = where_condition.merge(:company_id=>company_id) if company_id > 0
      where_condition = where_condition.merge(:cashflow_subject_id=>cashflow_subject_id) if cashflow_subject_id > 0
      where_condition = where_condition.merge(:corresponding_subject_id=>corresponding_subject_id) if corresponding_subject_id > 0

      @cash_flows = CashFlow.where(where_condition).page(params[:page]).per(15)
    end

  end
end
