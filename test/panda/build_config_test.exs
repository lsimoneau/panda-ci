defmodule Panda.BuildConfigTest do
  use ExUnit.Case

  test "it parses the .panda.yml file in the repo" do
    config = Panda.BuildConfig.load("test/sample_files/.panda.yml")
    assert config == %{ test: [~s{echo "this is a passing test"}] }
  end
end
