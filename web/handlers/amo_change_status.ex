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

  defp success_status do
    "142"
  end
end
