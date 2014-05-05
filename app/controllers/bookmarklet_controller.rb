class BookmarkletController < ApplicationController
  layout false

  def add_todo
    context_id = params[:c]
    desc = params[:d]
    notes = params[:n]
    
    @todo = Todo.new({ :description => desc, :notes => notes })
    context = current_user.contexts.find_by_id(context_id)
    @todo.context_id = context.id if context    
    @saved = @todo.save
    @todo.update_state_from_project if @saved
    
  end
end
