defmodule Tbforwarder.EventsController do
  use Tbforwarder.Web, :controller

  def create(conn, params) do
    IO.inspect params
    text conn, "OK"
  end
end
