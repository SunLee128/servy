defmodule Servy.BearController do
  alias Servy.Wildthings
  alias Servy.Bear
  @templates_path Path.expand("../../templates", __DIR__)

  defp render(conv, template, bindings \\ []) do
    content =
      @templates_path
      |> Path.join(template)
      |> EEx.eval_file(bindings)
  end

  def index(conv) do
    bears =
      Wildthings.list_bears()
      |> Enum.sort(&Bear.order_asc_by_name/2)

    render(conv, "index.eex", bears: bears)
  end

  @spec show(%{resp_body: any, status: any}, map) :: %{resp_body: <<_::64, _::_*8>>, status: 200}
  def show(conv, %{"id" => id}) do
    bear = Wildthings.get_bear(id)
    render(conv, "show.eex", bear: bear)
  end

  @spec create(%{resp_body: any, status: any}, map) :: %{
          resp_body: <<_::64, _::_*8>>,
          status: 201
        }
  def create(conv, %{"type" => type, "name" => name} = params) do
    %{conv | status: 201, resp_body: "Created a #{type} bear named #{name}!"}
  end

  def delete(conv, _params) do
    %{conv | status: 403, resp_body: "Deleting a bear is forbidden"}
  end
end
