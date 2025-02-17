class TodosController < ApplicationController
    before_action :set_todo, only: %i[show update destroy complete]
  
    # GET /todos
    def index
      if params[:filter] == 'pending'
        @todos = Todo.where(completed: false)
      elsif params[:filter] == 'completed'
        @todos = Todo.where(completed: true)
      else
        @todos = Todo.all
      end
      render json: @todos
    end
  
    # GET /todos/:id
    def show
      render json: @todo
    end
  
    # POST /todos
    def create
      @todo = Todo.new(todo_params)
      if @todo.save
        render json: @todo, status: :created
      else
        render json: @todo.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /todos/:id
    def update
      if @todo.update(todo_params)
        render json: @todo
      else
        render json: @todo.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /todos/:id
    def destroy
      @todo.destroy
      head :no_content
    end
  
    # PATCH /todos/:id/complete
    def complete
      @todo.update(completed: true)
      render json: @todo
    end
  
    private
  
    def set_todo
      @todo = Todo.find(params[:id])
    end
  
    def todo_params
      params.require(:todo).permit(:title, :description, :completed)
    end
  end
  