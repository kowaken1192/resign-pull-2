class RoomsController < ApplicationController
  before_action :set_q, only: [:index, :search]

  def index
    @user = current_user
    @rooms = @user.rooms
    @rooms = Room.all
  end

  def new
    @user = current_user
    @room = Room.new
  end

  def create
    @user = current_user
    @room = Room.new(room_params)
    @room.user_id = current_user.id
    if @room.save
      redirect_to @room, notice: 'Room was successfully created.'
    else
      render :new
    end
  end

  def show
    @user = current_user.id
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  def edit
    @user = current_user
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      redirect_to rooms_path
    else
      render "edit"
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to rooms_path
  end

  def search
    @results = @q.result(distinct: true)
    @rooms = Room.where(some_condition: true)
  end

  private

  def room_params
    params.require(:room).permit(:name, :introduction, :price, :address, :image, :user_id)
  end

  def set_q
    @q = Room.ransack(params[:q])
  end
end
