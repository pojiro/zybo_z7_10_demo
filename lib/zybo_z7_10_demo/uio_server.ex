defmodule ZyboZ710Demo.UioServer do
  use GenServer

  require Logger

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  # callbacks

  @impl true
  def init(_args) do
    send(self(), :loop)
    {:ok, %{}}
  end

  @impl true
  def terminate(_reason, _state) do
  end

  @impl true
  def handle_info(:loop, state) do
    System.cmd("/usr/local/bin/uio_sample.o", ~w"")
    Process.send_after(self(), :loop, 1)

    {:noreply, state}
  end
end
