class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all
    @user = current_user
    @reservation = @user.rooms
  end

  def new
    @room = Room.find(params[:room_id])
    @reservation = @room.reservations.new
    @reservation.user_id = current_user.id 
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @room = Room.find(params[:reservation][:room_id])
    @reservation.room_id = @room.id
    if @reservation.save
      redirect_to @reservation, notice: 'Reservation was successfully created.'
    else
      render "rooms/show"
    end
  end

  def update
    @reservation = Reservation.new(reservation_params)
  end

  def show
    @reservations = Reservation.all

    if @reservation.nil?
      flash[:error] = '予約情報が見つかりませんでした。'
      redirect_to root_path and return
    end

    @room = @reservation.room
    if @room.nil?
      flash[:error] = '部屋情報が見つかりませんでした。'
      redirect_to root_path and return
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
    @room = @reservation.room
  end

  def confirm
    @reservation = Reservation.new(reservation_params)
    @room = Room.find(params[:reservation][:room_id])
    @user_id = current_user.id
    @check_in = @reservation.check_in
    @check_out = @reservation.check_out

    if @reservation.check_in.nil?
      redirect_to @room, alert: "開始日を入力してください"
      return
    end
    
    if @reservation.check_out.nil?
      redirect_to @room, alert: "終了日を入力してください"
      return
    end

    if @reservation.check_out < @reservation.check_in
      redirect_to @room, alert: "終了日は開始日以降の日付にしてください"
      return
    end

    if @reservation.number_of_people.nil?
      redirect_to @room, alert: "正しい人数を入力してください"
      return
    end
    
    @total_day = (@check_out - @check_in).to_i
    @number_of_people = @reservation.number_of_people
    @total_price = @room.price.to_i * @total_day * @reservation.number_of_people.to_i
  end

  private

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :number_of_people, :room_id, :user_id)
  end
end
