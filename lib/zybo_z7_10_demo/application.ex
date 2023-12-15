defmodule ZyboZ710Demo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ZyboZ710Demo.Supervisor]

    children =
      [
        {ZyboZ710Demo.GpioServer, []},
        {ZyboZ710Demo.UioServer, []}
      ] ++ children(target())

    Supervisor.start_link(children, opts)
  end

  # List all child processes to be supervised
  def children(:host) do
    [
      # Children that only run on the host
      # Starts a worker by calling: ZyboZ710Demo.Worker.start_link(arg)
      # {ZyboZ710Demo.Worker, arg},
    ]
  end

  def children(_target) do
    [
      # Children for all targets except host
      # Starts a worker by calling: ZyboZ710Demo.Worker.start_link(arg)
      # {ZyboZ710Demo.Worker, arg},
    ]
  end

  def target() do
    Application.get_env(:zybo_z7_10_demo, :target)
  end
end
