defmodule Tbforwarder.RegisterCourseSession do

  def send_to_teachbase(fields) when is_map(fields) do
    if Map.size(fields) == length(white_list) do
      {:ok, json} = Poison.encode(fields)
      HTTPoison.start
      HTTPoison.post!(tb_url(fields["course_session_id"]), json, headers, stream_to: self)
    end
  end

  defp tb_url(course_session_id) do
    "#{tb_host}/endpoint/v1/course_sessions/#{course_session_id}/register?access_token=#{tb_access_token}"
  end


  defp validate_params(params) do
    
  end

  defp headers do
    %{"Content-Type" => "application/json"}
  end

  defp client_id do
    Application.get_env(:tbforwarder, :teachbase)[:client_id]
  end

  defp client_secret do
    Application.get_env(:tbforwarder, :teachbase)[:client_secret]
  end

  defp token_url do
    Application.get_env(:tbforwarder, :teachbase)[:token_url]
  end

  defp send_to_teachbase(fields) do
    :ok
  end
end
