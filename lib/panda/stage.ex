defmodule Panda.Stage do
  alias Porcelain.Process, as: Proc
  alias Porcelain.Result

  def execute(name, parent, config) do
    Enum.each(config.commands, fn(command) ->
      proc = %Proc{pid: pid} = Porcelain.spawn_shell(command, out: {:send,self()})
      await(name, parent, pid)
    end)
    run(name, parent, config, 0)
  end

  defp run(name, parent, %{ commands: [] }, status) do
    send(parent, {name, :exit, status})
  end
  defp run(name, parent, config, status) when status == 0 do
    [command|rest] = config.commands
    proc = %Proc{pid: pid} = Porcelain.spawn_shell(command, out: {:send,self()}, err: {:send, self()})
    status = await(name, parent, pid)
    run(name, parent, %{config | commands: rest }, status)
  end
  defp run(name, parent, _, status) do
    send(parent, {name, :exit, status})
  end

  defp await(name, parent, pid) do
    receive do
      {^pid, :data, _, data} ->
        send(parent, {name, :output, data})
        await(name, parent, pid)

      {^pid, :result, %Result{status: status}} ->
        status
    end
  end
end
