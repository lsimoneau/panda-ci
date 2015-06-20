defmodule Panda.BuildTest do
  use ExUnit.Case

  @build_dir Path.expand("~/panda-builds/test-repo/fake-id")

  setup do
    on_exit fn -> File.rm_rf!(@build_dir) end
  end

  test "it clones the specified repository into a directory named by build id" do
    Panda.Build.start(
      %{
        id: 'fake-id',
        git: "git@github.com:lsimoneau/test-repo.git"
      }
    )
    assert File.exists?(Path.join([@build_dir, "LICENSE"]))
  end
end
