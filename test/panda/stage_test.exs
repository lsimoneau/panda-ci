defmodule Panda.StageTest do
  use ExUnit.Case

  test "it executes a list of bash commands and sends the output back to the parent" do
    Panda.Stage.start(self, %{ commands: [
      "echo 'hello, stage'"
    ] })

    assert_receive({:ouptut, "hello, stage\n"})
    assert_receive({:exit, 0})
  end

  test "it runs multiple commands" do
    assert "hello, stage\nhow are you?\n" == Panda.Stage.run([
      "echo 'hello, stage'",
      "echo 'how are you?'"
    ])
  end
end
