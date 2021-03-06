class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy, :update_quantity]
  respond_to :html, :js
  skip_before_filter :verify_authenticity_token #, :only => [:index, :show, :update, :create]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
    @item  = Item.new
    @orders = Order.all

    respond_to do |format|
      format.html
      format.csv { render text: @items.to_csv } 
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to items_url }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:title, :lcode, :img_url, :description, :supplier_name, :weight, :supplier, :purchase_kg_usd, :purchase_kg_rur, :shipping_kg_usd, :shipping_kg_rur, :purachse_per_item_usd, :purachse_per_item_rur, :shipping_per_item_usd, :shipping_per_item_rur, :self_cost_usd, :self_cost_rur, :sale_cost, :sale_cost_final, :wh_quantity, :photo)
    end
end
