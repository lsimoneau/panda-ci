defmodule Panda.Build do
  def start(build) do
    [repo_name|_] = Regex.run(~r/\/(.*)\.git/, build.git, capture: :all_but_first)
    System.cmd("git", ["clone", build.git, Path.expand("~/panda-builds/#{repo_name}/#{build.id}")])
  end
end
