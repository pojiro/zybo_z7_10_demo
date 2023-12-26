defmodule ZyboZ710Demo.Overlay do
  @bitbin_path "/usr/local/overlays/zybo-z7-10-pmods-petalinux.bit.bin"
  @dtbo_path "/usr/local/overlays/zybo-z7-10-pmods-petalinux.dtbo"

  def do!() do
    {_, 0} = System.cmd("cp", ~w"#{@bitbin_path} /lib/firmware")

    {_, 0} = System.cmd("mkdir", ~w"/configfs/device-tree/overlays/full")

    :os.cmd(~c"cat #{@dtbo_path} > /configfs/device-tree/overlays/full/dtbo")
  end

  def pmods() do
    for i <- 886..889 do
      {:ok, gpio} = Circuits.GPIO.open(i, :input)
      Circuits.GPIO.read(gpio) |> IO.inspect()
    end
  end
end
