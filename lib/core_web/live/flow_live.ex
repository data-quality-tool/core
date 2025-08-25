defmodule CoreWeb.FlowLive do
  use CoreWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "React Flow Demo")}
  end

  def render(assigns) do
    ~H"""
    <div class="container mx-auto px-4 py-8">
      <h1 class="text-3xl font-bold mb-6">React Flow Demo</h1>
      <div class="bg-white rounded-lg shadow-lg p-6">
        <.react name="Flow" />
      </div>
    </div>
    """
  end
end
