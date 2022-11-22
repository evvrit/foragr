class LogsController < ApplicationController
  before_action :set_log, only: %i[show update delete]

  def index
    @logs = Log.all
    @logs = policy_scope(Log)
    authorize @logs
  end

  def new
  end

  def create
  end

  def update
  end

  def edit
  end

  def destroy
  end


  def show
  end

  private

  def set_log
    @log = Log.find(params[:id])
  end
end
