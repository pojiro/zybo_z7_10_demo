defmodule ZyboZ710Demo.GpioServer do
  use GenServer

  require Logger

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  # callbacks

  @impl true
  def init(_args) do
    {:ok, ld4} = Circuits.GPIO.open(912, :output)
    {:ok, btn4} = Circuits.GPIO.open(955, :input)
    {:ok, btn5} = Circuits.GPIO.open(956, :input)

    :ok = Circuits.GPIO.set_interrupts(btn4, :rising)
    :ok = Circuits.GPIO.set_interrupts(btn5, :both)

    {:ok, %{ld4: ld4, btn4: btn4, btn5: btn5}}
  end

  @impl true
  def terminate(_reason, _state) do
  end

  @impl true
  def handle_info({:circuits_gpio, 955, _timestamp, _value}, state) do
    System.cmd(
      "aplay",
      ~w"--device=hw:0,0 /usr/local/share/sounds/Kurzweil-K2000-Dual-Bass-C1_s32le.wav"
    )

    {:noreply, state}
  end

  def handle_info({:circuits_gpio, 956, _timestamp, value}, %{ld4: ld4} = state) do
    :ok = Circuits.GPIO.write(ld4, value)
    {:noreply, state}
  end
end
