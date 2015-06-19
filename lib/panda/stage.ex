defmodule Panda.Stage do
  def start(parent, config) do
  end

  def run(commands) do
    Enum.map(commands, fn(command) ->
      %Porcelain.Result{out: out} = Porcelain.shell(command)
      out
    end) |> Enum.join
  end
end
