require 'inquiries_decorator'

class InquiriesController < ApplicationController
  before_action :set_inquiry, only: [:show, :edit, :update, :destroy]

  # GET /inquiries
  # GET /inquiries.json
  def index
    @inquiries = Inquiry.all
  end

  # GET /inquiries/1
  # GET /inquiries/1.json
  def show
  end

  # GET /inquiries/new
  def new
    @inquiry = Inquiry.new
  end

  # GET /inquiries/1/edit
  def edit
  end

  # POST /inquiries
  # POST /inquiries.json
  def create
    @inquiry = Inquiry.new
    @inquiry.firstname = params[:inquiry][:firstname]
    @inquiry.lastname = params[:inquiry][:lastname]
    @inquiry.email = params[:inquiry][:email]
    @inquiry.message = params[:inquiry][:message]
    # create an instance/object of a BasicInquiry
    myInquiries = BasicInquiry.new(@inquiry.message)
    # add the extra features to the new inquiry
    if params[:inquiry][:stock].to_s.length > 0 then
      myInquiries = StockDecorator.new(myInquiries)
    end
    if params[:inquiry][:crypto].to_s.length > 0 then
      myInquiries = CryptoDecorator.new(myInquiries)
    end
    if params[:inquiry][:other].to_s.length > 0 then
      myInquiries = OtherDecorator.new(myInquiries)
    end
    ## populate the message and the other details
    @inquiry.message = myInquiries.details

    respond_to do |format|
      if @inquiry.save
      format.html { redirect_to @inquiry, notice: 'inquiry was successfully created.'}
      format.json { render :show, status: :created, location: @inquiry }
      else
      format.html { render :new }
      format.json { render json: @inquiry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inquiries/1
  # PATCH/PUT /inquiries/1.json
  def update
    respond_to do |format|
      if @inquiry.update(inquiry_params)
        format.html { redirect_to @inquiry, notice: 'Inquiry was successfully updated.' }
        format.json { render :show, status: :ok, location: @inquiry }
      else
        format.html { render :edit }
        format.json { render json: @inquiry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inquiries/1
  # DELETE /inquiries/1.json
  def destroy
    @inquiry.destroy
    respond_to do |format|
      format.html { redirect_to inquiries_url, notice: 'Inquiry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inquiry
      @inquiry = Inquiry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def inquiry_params
      params.require(:inquiry).permit(:firstname, :lastname, :email, :message)
    end
end
