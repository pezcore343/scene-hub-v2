class RsvpsController < ApplicationController
  def create
    respond_to do |format|
      @show = Show.find(params[:show_id])
      @rsvp = @show.rsvps.build(user: current_user)
      if @rsvp.save
        format.html do
          flash[:notice] = 'RSVPed successfully!'
          redirect_to show_path(@show)
        end
        format.json { render json: @rsvp }
      else
        format.html do
          render show_path(@show)
        end
        format.json { render json: @rsvp.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      rsvp = current_user.rsvps.find(params[:id])
      @show = rsvp.show
      if rsvp.destroy
        format.html do
          flash[:notice] = 'RSVP cancelled'
          redirect_to show_path(@show)
        end
        format.json { head :no_content }
      else
        render show_path(@show)
      end
    end
  end
end
