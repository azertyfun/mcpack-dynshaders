## How to build

Use [mcpack-template](https://github.com/azertyfun/mcpack-template) to build the datapack:

```
$ cd ../mcpack-template
$ python -m mcpack_template ../mcpack-dynshaders/ ~/.local/share/PrismLauncher/instances/26.3/minecraft/saves/demo/datapacks/dynshaders ../mcpack-dynshaders/values.toml
```

## Philosophy

See [my video on the subject](https://www.youtube.com/watch?v=kAySDvsvJgw) for the broader context.

I am not an experienced datapack maker, and to achieve simple things like "I want an effect that gradually tapers off the further away the player is" I could learn to do some very complex stuff with entities... or I could repeat `execute as @a[distance=..X]` 20 times and it would be easy to write and maintain.

Feel free to come up with another approach for you own datapack. All that matters ultimately is that the `iris-uniforms-X` scoreboards are set for your player according to your shaderpack's specifications.

## How to use

* Every file gets rendered as a [Jinja2](https://jinja.palletsprojects.com/) template
* `values.toml` contents are made available to the template as `v`
* Multiple files at once can be created if a directory contains a `meta.toml`. See `data/dynshaders/function/set/meta.toml` or the `mcpack-template` source for more info.
