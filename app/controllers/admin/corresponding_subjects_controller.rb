module Admin
  class CorrespondingSubjectsController < Admin::BaseController

    def index
      @corresponding_subjects = CorrespondingSubject.page(params[:page]).per(15)
    end

    def show
      @corresponding_subject = CorrespondingSubject.find(params[:id])
    end

    def new
      @corresponding_subject = CorrespondingSubject.new
    end

    def edit
      @corresponding_subject = CorrespondingSubject.find(params[:id])
    end

    def create
      @corresponding_subject = CorrespondingSubject.new(params[:corresponding_subject])

      if @corresponding_subject.save
        redirect_to admin_corresponding_subject_path(@corresponding_subject)
      else
        render action: "new"
      end
    end

    def update
      @corresponding_subject = CorrespondingSubject.find(params[:id])

      if @corresponding_subject.update_attributes(params[:corresponding_subject])
        redirect_to admin_corresponding_subject_path(@corresponding_subject)
      else
        render action: "edit"
      end
    end

    def destroy
      @corresponding_subject = CorrespondingSubject.find(params[:id])
      @corresponding_subject.destroy

      redirect_to admin_corresponding_subjects_url
    end
  end
end
