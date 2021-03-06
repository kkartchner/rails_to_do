class ToDosController < ApplicationController
  before_action :authenticate_user!
  before_action :find_to_do, only: [:destroy, :edit, :update, :toggle]

  def index
    @total_record_num = current_user.to_dos.count
    task_show = params[:task_show]
    if task_show.nil?
      redirect_to to_dos_path(task_show: 20)
    else
      if task_show == "all"
        @task_show_num = @total_record_num
      elsif is_number?(task_show) && task_show.to_i >= 0 
        @task_show_num = task_show.to_i 
        if @task_show_num > @total_record_num
          redirect_to to_dos_path(task_show: "all")
        end
      else 
        redirect_to to_dos_path(task_show: 20)
      end
    end

    @todos = current_user.to_dos.order("updated_at DESC").limit(@task_show_num)
  end

  def create
    @todo = current_user.to_dos.build(todo_params)
    @todo.completed = false

    if (!@todo.save)
      flash[:alert] = @todo.errors.full_messages[0]
    end
    redirect_to to_dos_path
  end

  def destroy
    @todo.destroy
    redirect_to to_dos_path
  end

  def edit
  end

  def update
    if (@todo.update(todo_params))
      flash[:notice] = "Task updated successfully!"
      redirect_to to_dos_path
    else
      render 'edit'
    end
  end

  def toggle
    @todo.completed = !@todo.completed 
    @todo.save
    redirect_to to_dos_path
  end

  private

  def find_to_do
    @todo = ToDo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:description, :completed)
  end
end
