defmodule Proba do
  @moduledoc """
  Polls a website at set interval and checks if it is updated.
  If it is updated it sends a notification using the program terminal-notifier. (Mac only)

  Example
      $ ./proba --url=example.com --polltime=2000 --selector="body"
  """

  def scraper(url, selector) do
    fn () ->
      HTTPotion.get(url)
      |> Map.fetch(:body)
      |> elem(1)
      |> Floki.find(selector)
      |> Floki.text
    end
  end

  def time do
    {h, m, s} = :calendar.local_time() |> elem(1)
    "#{h}:#{m}:#{s}"
  end

  def sender(scrap, text, url, polltime) do

    Process.send_after self(), scrap, polltime

    receive do
      textfn ->
        new_text = textfn.()
        if new_text === text do
          IO.puts IO.ANSI.faint <> "#{time}: No change"
          sender(scrap, new_text, url, polltime)
        else
          IO.puts IO.ANSI.reset <> IO.ANSI.green <> "#{time}: PAGE CHANGED!"
          System.cmd "terminal-notifier",
          ["-message", url,
          "-sound", "DEFAULT",
          "-open", url,
          "-title", "Page Updated!"]
          url
        end
    end
  end

  def main(args) do

      # Default values
      default = [polltime: 60000, selector: "body"]

      {options, _, _} = OptionParser.parse(args,
          switches: [
            url: :string,
            polltime: :integer,
            selector: :string])

      url = options[:url]

      options = Enum.map(default, fn {k, v} -> {k, (if options[k], do: options[k], else: v)} end)
      if url do
        IO.puts "Starting website monitoring of #{url}\nCancel with Ctrl-C"
        unless String.contains?(url, "http"), do: url = "http://" <> url
        scrapfn = scraper(url, options[:selector])
        sender(scrapfn, scrapfn.(), url, options[:polltime])
      else
        IO.puts IO.ANSI.red <> "ERROR: Missing input: --url"
      end
  end
end

