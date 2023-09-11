# frozen_string_literal: true

class FlatsController < ApplicationController
  before_action :find_flat, only: %i[show update destroy update edit]

  def show
    authorize @flat
  end

  def index
    @flats = policy_scope(Flat)
    return unless params[:query].present?

    @flats = @flats.where('name LIKE ?', "%#{params[:query]}%")
  end

  def new
    @flat = Flat.new
    authorize @flat
  end

  def edit
    authorize @flat
  end

  def update
    authorize @flat
    if @flat.update(flat_params)
      redirect_to flat_path(@flat.id)
    else
      redirect_to edit_flat_path(@flat.id)
    end
  end

  def create
    @flat = Flat.new(flat_params)
    @flat.user = current_user
    if @flat.save # Will raise ActiveModel::ForbiddenAttributesError
      redirect_to flat_path(@flat.id)
    else
      redirect_to flats_path
    end
    authorize @flat
  end

  def destroy
    authorize @flat
    @flat.destroy
    redirect_to flats_path
  end

  private

  def find_flat
    @flat = Flat.find(params[:id])
  end

  def flat_params
    params.require(:flat).permit(:name, :address, :description, :price_per_night, :number_of_guests, :url)
  end
end
