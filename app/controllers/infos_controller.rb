class InfosController < ApplicationController
  # GET /infos
  # GET /infos.json

  def edit
    @info = Info.find(params[:id])
  end

  # PUT /infos/1
  # PUT /infos/1.json
  def update
    @info = Info.find(params[:id])

    respond_to do |format|
      if @info.update_attributes(params[:info])
        format.html { redirect_to diagnostics_edit_path, notice: 'Information was successfully updated.' }
      else
        redirect_to root_path, alert: 'Information could not be updated.'
      end
    end
  end

end
