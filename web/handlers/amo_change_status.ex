defmodule Tbforwarder.AmoChangeStatus do
  def perform(params) do
    case parse_params(params) do
      {:ok, fields} -> send_to_teachbase(fields)
      _ -> :error
    end
  end

  defp parse_params(params) do
    status = params["leads"]["status"]["0"]
    custom_fields = status["custom_fields"]
    status_id = status["status_id"]
    if status_id == success_status() do
      {:ok, prepare_custom_fields(custom_fields)}
    else
      {:error, :status_not_success}
    end
  end

  defp prepare_custom_fields(custom_fields) do
    res = Enum.filter_map(
      custom_fields,
      fn {index, attrs} -> Enum.member?(white_list, attrs["name"]) end,
      fn {k, v} -> {v["name"], v["values"]["0"]["value"]} end
    )
    Map.new(res)
  end

  defp white_list do
    ["email", "course_session_id"]
  end

  defp send_to_teachbase(fields) when is_map(fields) do
    if Map.size(fields) == length(white_list) do
      {:ok, json} = Poison.encode(fields)
      HTTPoison.start
      HTTPoison.post!(tb_url(fields["course_session_id"]), json, headers, stream_to: self)
    end
  end

  defp send_to_teachbase(fields) do
    :ok
  end

  defp tb_url(course_session_id) do
    "#{tb_host}/endpoint/v1/course_sessions/#{course_session_id}/register?access_token=#{tb_access_token}"
  end

  defp headers do
    %{"Content-Type" => "application/json"}
  end

  defp tb_access_token do
    Application.get_env(:tbforwarder, :teachbase)[:access_token]
  end

  defp tb_host do
    Application.get_env(:tbforwarder, :teachbase)[:host]
  end

  defp success_status do
    "142"
  end
end
