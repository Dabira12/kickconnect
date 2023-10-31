class AddressesController < ApplicationController


def new
    @address = current_user.address.build
end


def show_all
    # @address = current_user.address
  end
end