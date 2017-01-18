class Customer::TopController < ApplicationController
  def index
    raise Forbidden
    render action: 'index'
  end
end
