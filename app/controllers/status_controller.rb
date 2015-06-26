class StatusController < ApplicationController
  def index
    render({ json: { status: "OK", foo: "bar" } })
  end
end
