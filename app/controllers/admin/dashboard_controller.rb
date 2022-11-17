class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['USER_NAME'], password: ENV['PASS_WORD']
  
  def show
    @category_count = Category.count
    @products_count = Product.count
  end
end
