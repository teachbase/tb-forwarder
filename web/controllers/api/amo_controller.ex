defmodule Tbforwarder.Api.AmoController do
  use Tbforwarder.Web, :controller

  def register(conn, params) do
    Tbforwarder.AmoChangeStatus.perform(params)
    text conn, "OK"
  end
end
