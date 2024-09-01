defmodule SpellChecker.MixProject do
  use Mix.Project

  def project do
    [
      app: :spell_checker,
      version: "0.1.1",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "spell_checker",
      source_url: "https://github.com/Adeyeye93/SpellChecker",
      docs: [
        main: "SpellChecker",
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.29", only: :dev, runtime: false},
    ]
  end

  defp description() do
    "The SpellChecker module checks word correctness and suggests alternatives."
  end

  defp package() do
    [
      name: "spell_checker",
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/Adeyeye93/SpellChecker"},
      maintainers: ["Adeyeye Seyi"],
      files: ~w(lib mix.exs README* LICENSE* test)
    ]
  end
end
