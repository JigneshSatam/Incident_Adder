class IncidentsController < ApplicationController
  before_action :set_incident, only: [:show, :edit, :update, :destroy]
  # layout :false

  # GET /incidents
  # GET /incidents.json
  def index
    @incidents = Incident.all
    respond_to do |format|
      format.html { }
      format.xml {
        render :text=>@incidents.to_xml(root:"data")
        }
    end
  end

  def news
    @incidents = Incident.where("updated_at < ?", Time.now.yesterday)
    render xml: @incidents
  end

  # GET /incidents/1
  # GET /incidents/1.json
  def show
    @incident = Incident.find(params[:id])
    respond_to do |format|
      format.js { }
      # format.html {
      #   render partial: "show", locals: {incident: @incident}
      # }
      # format.xml {
      #   render xml: @incident.to_xml(only:[:latitude, :longitude, :title, :description], root: "data" )
      # }
    end
  end


  # GET /incidents/new
  def new
    @incident = Incident.new
    respond_to do |format|
      format.html {
        @incident.latitude = params[:latitude]
        @incident.longitude = params[:longitude]
        render partial: "new", locals: { incident: @incident}
      }

      format.xml {
        render xml: @incident.to_xml(only:[:latitude, :longitude, :title, :description], root: "data" )
      }
    end
  end

  # GET /incidents/1/edit
  def edit
    @incident = Incident.find(params[:id])
    respond_to do |format|
      format.js {  }

    end
  end

  # POST /incidents
  # POST /incidents.json
  def create
    @incident = Incident.new(incident_params)

    respond_to do |format|
      if @incident.save
        flash[:notice] = 'Incident was successfully created.'
        format.js { }
        # format.xml {render xml: @incident, status: :created, location: @incident }
        # format.html { redirect_to @incident, notice: 'Incident was successfully created.' }
        # format.json { render :show, status: :created, location: @incident }
      else
        format.html { render :new }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
        format.xml {render xml: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /incidents/1
  # PATCH/PUT /incidents/1.json
  def update
    respond_to do |format|
      if @incident.update(incident_params)
        flash[:notice] = 'Incident was successfully created.'
        format.js { }
        format.html { redirect_to @incident, notice: 'Incident was successfully updated.' }
        format.json { render :show, status: :ok, location: @incident }
      else
        format.html { render :edit }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incidents/1
  # DELETE /incidents/1.json
  def destroy
    @incident.destroy
    respond_to do |format|
      format.html { redirect_to incidents_url, notice: 'Incident was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_incident
      @incident = Incident.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def incident_params
      params.require(:incident).permit(:mountain, :latitude, :longitude, :when, :title, :description)
    end
end
