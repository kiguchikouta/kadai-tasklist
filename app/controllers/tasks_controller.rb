class TasksController < ApplicationController

before_action :require_user_logged_in
before_action :correct_user, only: [:destroy]
# before_action :set_task, only: [:show, :edit, :update, :destroy]

    def index
        redirect_to root_url
    end
    
    def show
        @task = Task.find(params[:id])
    end
    
    def new
        @task = Task.new
    end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'メッセージの投稿が完了しました'
      redirect_to root_url
    else
      # この後toppages#indexに飛ばすもののアクションを実行しないため、
      # toppages_controllerで設定しているインスタンス変数を同じものを事前にここで用意しておく必要がある
      @tasks = current_user.tasks.order(id: :desc).page(params[:page]).per(20)
      flash.now[:danger] = 'メッセージが投稿できませんでした'
      render 'new'
    end
  end
    
    # def create
    #     @task = Task.new(task_params)
        
    #     if @task.save
    #         flash[:success] = 'タスク登録完了！'
    #         redirect_to @task
    #     else
    #         flash.now[:danger] = 'タスク登録失敗、やり直し'
    #         render 'new'
    #     end
    # end
    
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
            flash.now[:danger]='タスク登録失敗、やり直し'
            render :edit
        end
    end
    
    def destroy
        # @task = Task.find(params[:id])
        @task.destroy
        
        flash[:success]='タスク削除完了！ゆっくり休みましょう'
        
        # マイクロポストの方と違って、リダイレクトバックすると、そもそも消したページに行くことになって、showでエラーが起きる
        # redirect_back(fallback_location: root_path)
        redirect_to root_url
    end

    private
    
    def task_params
        params.require(:task).permit(:content, :status)
    end
    
    def set_task
        @task = Task.find(params[:id])
    end
      
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end

    
end
