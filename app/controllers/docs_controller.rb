class DocsController < ApplicationController
  def index
    render layout: 'swagger'
  end
end
