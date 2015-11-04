# Proba
> Website monitor written in Elixir

A pun with the english word probe and the swedish word prova, meaning to test something. Coinciding well with me testing out Elixir.

It monitors a site and when it is done it sends a notification with terminal-notifier (needs to be installed).

```sh
$ ./proba --url=https://github.com/vikeri
```

## Parameters
```
--url
	The url to poll (does not work with redirects)

--polltime
	Poll interval (in ms)

--selector
	CSS selector to watch, eg. "body" or "#footer"	
	
```


## Requirements

* Elixir (the escript does not seem to work with only Erlang yet)
* mix (for building from source)
* Homebrew (for installing terminal-notifier)

## Installation

### 1. Install [terminal-notifier](https://github.com/julienXX/terminal-notifier)
```
$ brew install terminal-notifier
```

### 2. Download executable

https://github.com/vikeri/proba/releases/download/v0.0.1/proba

### 2. ALT: Build from source

```sh
$ git clone git@github.com:vikeri/proba.git
$ cd proba
$ mix escript.build
```
