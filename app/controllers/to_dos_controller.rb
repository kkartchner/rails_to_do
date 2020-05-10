class ToDosController < ApplicationController
  def index
    @todos = ToDo.all
  end

  def new
    @todo = ToDo.new
  end

  def create
    @todo = ToDo.new(todo_params)
    @todo.save
    redirect_to to_dos_path
  end 

  private def todo_params
    params.require(:todo).permit(:description, :completed)
  end
end
