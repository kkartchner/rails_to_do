class ToDosController < ApplicationController
  before_action :authenticate_user!
  def index
    @total_record_num = current_user.to_dos.count
    if params[:task_show].present? 
      if params[:task_show] == "all"
        @task_show_num = @total_record_num
      else 
        @task_show_num = params[:task_show].to_i
      end
    else
      redirect_to to_dos_path(task_show: 20)
    end

    @todos = current_user.to_dos.order("created_at DESC").limit(@task_show_num)
  end

  def create
    @todo = current_user.to_dos.build(todo_params)
    @todo.completed = false

    if (!@todo.save)
      @todo.errors.full_messages.each do |msg|
        flash[:msg] = msg
      end
    end
    redirect_to to_dos_path
  end

  def destroy
    @todo = ToDo.find(params[:id])
    @todo.destroy
    redirect_to to_dos_path
  end

  def edit
    @todo = ToDo.find(params[:id])
  end

  def update
    @todo = ToDo.find(params[:id])

    if (@todo.update(todo_params))
      flash[:notice] = "Task updated successfully!"
      redirect_to to_dos_path
    else
      render 'edit'
    end
  end

  def toggle
    @todo = ToDo.find(params[:id])
    @todo.completed = !@todo.completed 
    @todo.save
    redirect_to to_dos_path
  end

  private def todo_params
    params.require(:todo).permit(:description, :completed)
  end
end
