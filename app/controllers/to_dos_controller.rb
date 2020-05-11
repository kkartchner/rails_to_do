class ToDosController < ApplicationController
  def index
    @todos = ToDo.all
  end

  def create
    @todo = ToDo.new(todo_params)
    if (@todo.save)
      flash[:notice] = "Task created successfully!"
    else
      @todo.errors.full_messages.each do |msg|
        flash[:msg] = msg
      end
    end
    redirect_to to_dos_path
  end

  def destroy
    @todo = ToDo.find(params[:id])
    @todo.destroy
    flash[:notice] = "Task deleted successfully!"
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

  private def todo_params
    params.require(:todo).permit(:description, :completed)
  end
end
