defmodule Servy.Bear do
  defstruct id: nil, name: "", type: "", hibernating: false

  def is_grizzly(bear) do
    bear.type == "Grizzly"
  end

  @spec order_asc_by_name(atom | %{name: any}, atom | %{name: any}) :: boolean
  def order_asc_by_name(b1, b2) do
    b1.name <= b2.name
  end
end
