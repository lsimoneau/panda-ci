defmodule Panda.StageTest do
  use ExUnit.Case

  test "it executes a list of bash commands" do
    assert "hello, stage\n" == Panda.Stage.run([
      "echo 'hello, stage'"
    ])
  end

  test "it runs multiple commands" do
    assert "hello, stage\nhow are you?\n" == Panda.Stage.run([
      "echo 'hello, stage'",
      "echo 'how are you?'"
    ])
  end
end
