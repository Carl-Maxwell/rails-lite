# Rails Lite

I made this project for my own edification, learning more about how rails
works by creating a simulacrum.

To run the server do:

```bash
cd rails-lite
bundle
ruby ./bin/server
```

It also provides a command line interface (similar to `rails console`)

```bash
ruby ./bin/console
```

## Wallhack

[Wallhack](https://github.com/modred11/wallhack-cmdline-util) is a command line utility that
recreates a couple of the functions of the `rails` command line utility.

```bash
wallhack console
```

```bash
wallhack server
```

## SQLObject

SQLObject Method            | Description
----------------------------|--------------------
self.columns                |
self.finalize!              |
{column}                    |
{column}=(value)            |
self.table_name=(table_name)|
self.table_name             |
self.all                    |
self.parse_row(row)         |
self.parse_all(rows)        |
self.find(id)               |
initialize(params = {})     |
self.create(params = {})    |
attributes                  |
attribute_values            |
insert                      |
update                      |
\_update                    |
destroy                     |
destroy!                    |
save                        |
parameterize                |
