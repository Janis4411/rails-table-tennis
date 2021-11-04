class TablesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :index, :show]

  def index
    @tables = Table.where( "location LIKE ?", "% Berlin%" ).geocoded

    @geojson = build_geojson

    @tables_geo = @tables.map do |table|
      {
        lat: table.latitude,
        lng: table.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { table: table }),
        image_url: helpers.asset_url('table-tennis-solid.svg')
      }
    end
  end

  def user_index
    @tables = Table.where("userid = ?",current_user.id).geocoded
  end

  def show
    @table = Table.find(params[:id])
  end

  def create
    @table = Table.new(table_params)
    @table[:userid] = current_user.id
    @table.save
    redirect_to user_index_path
  end

  def new
    @table = Table.new
  end

  def edit
    @table = Table.find(params[:id])
  end

  def update
    @table = Table.find(params[:id])
    @table.update(table_params)
    redirect_to user_index_path
  end

  def destroy
    @table = Table.find(params[:id])
    @table.destroy

    redirect_to user_index_path
  end

  private

  def table_params
    params.require(:table).permit(:description, :location, :userid, :table_photo)
  end

  def build_geojson
    {
      type: "FeatureCollection",
      features: @tables.map(&:to_feature)
    }
  end
end
