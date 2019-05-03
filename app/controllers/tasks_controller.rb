class TasksController < ApplicationController
    def index
        @task = Task.all
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
            flash[:success] = 'タスク登録完了！'
            redirect_to @task
        else
            flash[:danger] = 'タスク登録失敗、やり直し'
            render :new
        end
    end
    
    def edit
        @task = Task.find(params[:id])
    end
    
    def update
        @task = Task.find(params[:id])
        # なぜかcreateと異なり、ストロングパラメータは使用しない
        # かわりに下のupdateで、ストロングパラメータを使用する（謎だが、仕様として暗記する）
        
        if @task.update(task_params)
            flash[:success]='タスク更新完了！'
            redirect_to @task
        else
            flash[:danger]='タスク登録失敗、やり直し'
            render :edit
        end
    end
    
    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        
        flash[:success]='タスク削除完了！ゆっくり休みましょう'
        redirect_to tasks_url
    end

    private
    
    def task_params
        params.require(:task).permit(:content)
    end
    
end
