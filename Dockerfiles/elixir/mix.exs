defmodule MasterApp.Mixfile do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      app: :app,
      version: "0.1.0",
      elixir: "~> 1.3",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      test_coverage: [tool: ExCoveralls],
      deps: deps()
    ]
  end

  def application do
    [
      applications: [],
    ]
  end

  def deps do
    [
      # {:lager, github: "basho/lager"},
      {:exrm, "~> 1.0.8", optional: true, warn_missing: false},
      {:ex_doc, "~> 0.12", only: :dev},
      {:dogma, "~> 0.1", only: :dev},
      {:excoveralls, "~> 0.5"},
      {:httpotion, "~> 3.0.0"},
      {:poison, "~> 2.2.0"},
      {:cowboy, "~> 1.0.0"},
      {:plug, "~> 1.0"},
      {:ecto, "~> 2.0"},
      {:etslib, git: "https://github.com/sergey-ivlev/etslib.git",
               branch: "master"},
    ]
  end
end
