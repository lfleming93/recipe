class RecipeEntriesController < ApplicationController
  before_action :find_resource, only: :show

  def index
    @resources = RecipeEntry.all
  end

  def show
    redirect_to :index, flash: 'Not found' unless @resource.id.present?
  end

  private

  def find_resource
    @resource = RecipeEntry.new(params[:id])
  end
end
