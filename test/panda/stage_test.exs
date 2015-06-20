defmodule Panda.StageTest do
  use ExUnit.Case

  test "it executes a list of bash commands and sends the output back to the parent" do
    Panda.Stage.execute(:test_1, self, %{ commands: [
      "echo 'hello, stage'"
    ] })

    assert_received({:test_1, :output, "hello, stage\n"})
    assert_received({:test_1, :exit, 0})
  end

  test "it runs multiple commands" do
    Panda.Stage.execute(:test_1, self, %{ commands: [
      "echo 'hello, stage'",
      "echo 'how are you?'"
    ] })

    assert_received({:test_1, :output, "hello, stage\n"})
    assert_received({:test_1, :output, "how are you?\n"})
    assert_received({:test_1, :exit, 0})
  end

  test "it receives non-zero exit codes" do
    Panda.Stage.execute(:test_1, self, %{ commands: [
      "echo 'hello, stage'",
      "false"
    ] })

    assert_receive({:test_1, :output, "hello, stage\n"})
    assert_receive({:test_1, :exit, 1})
  end

  test "it stops when receiving an exit code" do
    Panda.Stage.execute(:test_1, self, %{ commands: [
      "echo 'hello, stage'",
      "false",
      "echo 'how are you?'"
    ] })

    assert_receive({:test_1, :output, "hello, stage\n"})
    assert_receive({:test_1, :exit, 1})
    refute_receive({:test_1, :output, "houw are you?\n"})
  end

  test "it handles commands that return multiple lines of output" do
    Panda.Stage.execute(:test_1, self, %{ commands: [
      "./test/sample_files/multiline_output.sh"
    ] })

    assert_receive({:test_1, :output, "foo\n"})
    assert_receive({:test_1, :output, "bar\n"})
  end

  test "it captures output to stderr" do
    Panda.Stage.execute(:test_1, self, %{ commands: [
      "./test/sample_files/stderr_output.sh"
    ] })

    assert_receive({:test_1, :output, "error\n"})
  end
end
