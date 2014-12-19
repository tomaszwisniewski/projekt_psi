class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource except: [:create, :send_question]

  # GET /orders
  # GET /orders.json
  def index
    if current_user.admin 
      @orders = Order.all
    else
      @orders = Order.where("user_id == ?", current_user.id)
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  def send_question
    QuestionMailer.send_question(params).deliver
    @order = Order.find(params[:order][:id])
    redirect_to order_path(@order)
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @user = current_user
    @order = @user.orders.create(order_params)

    @category = Category.find_by_id(order_params[:category_id])
    @order.category = @category
    @category.orders << @order

    @state = current_state
    @order.state = @state
    @state.orders << @order

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @order }
      else
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :description, :price, :address, :user_id, :category_id, :image)
    end
end
