class WebhooksController < ApplicationController
  before_action :set_webhook, only: %i[ show  destroy ]
  skip_before_action :verify_authenticity_token, only:[:create]

  # GET /webhooks or /webhooks.json
  def index
    @webhooks = Webhook.all
  end

  # GET /webhooks/1 or /webhooks/1.json
  def show
  end

  # GET /webhooks/new
  def new
    @webhook = Webhook.new
  end

  # GET /webhooks/1/edit
  def edit
  end

  # POST /webhooks or /webhooks.json
  def create
    @webhook = Webhook.new(webhook_params)
    @webhook.source = params[:source]
    @webhook.event = params[:event]
    
    @webhook.data = params[:data]
  
      if @webhook.save
        WebhookJob.perform_later(@webhook)
       
       
        render json: {status: :ok}, status: :ok
      else
       
        render json: {errors: @webhook.errors}, status: :unprocessable_entity
      end
 
  end

  # PATCH/PUT /webhooks/1 or /webhooks/1.json
  def update
    respond_to do |format|
      if @webhook.update(webhook_params)
        format.html { redirect_to webhook_url(@webhook), notice: "Webhook was successfully updated." }
        format.json { render :show, status: :ok, location: @webhook }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @webhook.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /webhooks/1 or /webhooks/1.json
  def destroy
    @webhook.destroy

    respond_to do |format|
      format.html { redirect_to webhooks_url, notice: "Webhook was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_webhook
      @webhook = Webhook.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def webhook_params
    #   params.require(:webhook).permit(:source, :message, :event).tap do |whitelisted|
    #     whitelisted[:data] = params[:webhook][:data]
    #   end
      # params.require(:webhook).slice(:source, :message, :event, :data)
      params.require(:webhook).permit(:source, :message, :event, data:[])
    end
end
