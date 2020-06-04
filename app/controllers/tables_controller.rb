class TablesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :index, :show]

  def index
    @tables = Table.where( "location LIKE ?", "% Berlin%" ).geocoded

    @markers = @tables.map do |table|
      {
        lat: table.latitude,
        lng: table.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { table: table }),
        image_url: helpers.asset_url('table-tennis-solid.svg')
      }
    end
  end

  def show
    @table = Table.find(params[:id])
  end

  def create
    @table = Table.new(table_params)
    @table.save
    redirect_to table_path(@table)
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

    redirect_to table_path(@table)
  end

  def destroy
    @table = Table.find(params[:id])
    @table.destroy

    redirect_to tables_path
  end

  private

  def table_params
    params.require(:table).permit(:description, :location)
  end
end
