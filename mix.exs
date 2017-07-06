defmodule Memoz.Mixfile do
  use Mix.Project

  def project do
    [app: :memoz,
     version: "0.2.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps(),
     source_url: "https://github.com/bakenezumi/memoz"]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [{:ex_doc, "~> 0.14", only: :dev}]
  end

 defp description do
    """
    MemoZ run recursive while memoizing anonymous functions.
    """
  end

  defp package do
    # These are the default files included in the package
    [
      name: :memoz,
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["bakenezumi"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/bakenezumi/memoz"}
    ]
  end

end
