# Proba
> Website monitor written in Elixir

A pun with the english word probe and the swedish word prova, meaning to test something. Coinciding well with me testing out Elixir.

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

## Installation

### Build from source

```sh
$ git clone git@github.com:vikeri/proba.git
$ cd proba
$ mix escript.build
```