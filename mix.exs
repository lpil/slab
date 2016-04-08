defmodule Slab.Mixfile do
  use Mix.Project

  @version "0.0.1"

  def project do
    [
      app: :slab,
      version: @version,
      elixir: "~> 1.0",
      deps: deps,
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,

      name: "Slab",
      source_url: "https://github.com/lpil/slab",
      description: "Lightweight HTML templates",
      package: [
        maintainers: ["Louis Pilfold"],
        licenses: ["MIT"],
        links: %{ "GitHub" => "https://github.com/lpil/slab" },
      ]
    ]
  end

  def application do
    [applications: []]
  end

  defp deps do
    [
      # Code style linter
      {:dogma, "~> 0.0", only: [:dev, :test]},
      # Automatic test runner
      {:mix_test_watch, "~> 0.0", only: :dev},
    ]
  end
end
