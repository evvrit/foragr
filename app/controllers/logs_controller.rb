class LogsController < ApplicationController
  before_action :set_log, only: %i[show update delete]

  def index
    @logs = policy_scope(Log).all.order(created_on: :desc)
  end

  def new
    @log = Log.new
    authorize @log
  end

  def create
    @log = Log.new(log_params)
    @log.user_id = current_user.id
    if @log.save
      redirect_to log_path(@log)
    else
      render :new, status: :unprocessable_entity
    end
    authorize @log
  end

  def update
  end

  def edit
  end

  def destroy
  end


  def show
    # @log = policy_scope(Log)
    # raise
    authorize @log
  end

  # Test page for Vinh Tho to play with css
  def css_test
    @logs = Log.all
    @logs = policy_scope(Log)
    authorize @logs
  end

  private

  def set_log
    @log = Log.find(params[:id])
  end

  def log_params
    params.require(:log).permit(:content, :seed_photo, :created_on, :user_id, [:cache_id], :title, photos: [])
  end
end
