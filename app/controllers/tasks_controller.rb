class TasksController < ApplicationController
    def index
        if params[:title].present? && params[:explanation].present?
            @tasks = Task.where(title: params[:title]).where("explanation LIKE ?", "%#{params[:explanation]}%")
        elsif params[:title].present?
            @tasks = Task.where("title LIKE ?", "%#{params[:title]}%")
        elsif params[:explanation].present?
            @tasks = Task.where("explanation LIKE ?", "%#{params[:explanation]}%")
        else
            @tasks = Task.all
        end
    end

    def show
        @task = Task.find(params[:id])
    end

    def new
        @task = Task.new
    end

    def create
        @task = Task.new(task_params)
        if @task.save
            redirect_to tasks_url, notice: '保存が完了しました。'
        else
            flash[:error_messages] = @task.errors.full_messages
            render :new
        end
    end

    def edit
        @task = Task.find(params[:id])
    end

    def update
        @task = Task.find(params[:id])
        if @task.update(task_params)
            redirect_to @task, notice: '更新が完了しました。'
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        redirect_to tasks_url, notice: 'タスクが削除されました。'
    end

    private

    def task_params
        params.require(:task).permit(:title, :explanation, :due_date, :updated_at, :create_at)
    end

end