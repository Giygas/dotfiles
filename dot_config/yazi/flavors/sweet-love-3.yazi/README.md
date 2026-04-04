<div align="center">
  <img src="https://github.com/sxyazi/yazi/blob/main/assets/logo.png?raw=true" alt="Yazi logo" width="20%">
</div>

<h3 align="center">
	Sweet Love 3 Flavor for <a href="https://github.com/sxyazi/yazi">Yazi</a>
</h3>

## Preview

A muted olive-earthy variation of the Sweet Love theme. The most subdued of the three — desaturated olive `#585C49` dominates as the primary accent, with burnt orange and warm gold providing contrast pops.

## Installation

Copy the `sweet-love-3.yazi` directory into your Yazi flavors directory:

```sh
cp -r sweet-love-3.yazi ~/.config/yazi/flavors/
```

## Usage

Set the content of your `theme.toml` to enable it as your _dark_ flavor:

```toml
[flavor]
dark = "sweet-love-3"
```

Make sure your `theme.toml` doesn't contain anything other than `[flavor]`, unless you want to override certain styles of this flavor.

See the [Yazi flavor documentation](https://yazi-rs.github.io/docs/flavors/overview) for more details.

## Differences from Sweet Love

| Element | Sweet Love | Sweet Love 3 |
|---|---|---|
| Primary accent | `#D17B49` orange | `#585C49` muted olive |
| Borders/tabs | Orange | Muted olive |
| CWD | Olive `#7B8748` | Gold `#AF865A` |
| Keywords | Dark gold `#8F6840` | Burnt orange `#AC5D2F` |
| Functions | Orange | Muted olive `#585C49` |
| Operators | Olive `#7B8748` | Bright olive `#647035` |
| Strings | Sage `#6D715E` | Olive `#7B8748` |
| Comments | Tan `#978965` | Slate `#444B4B` |
| Errors | Burnt orange | Burnt orange `#AC5D2F` |
| Classes/types | Gold `#AF865A` | Gold `#AF865A` (same) |
| Surface | `#402E2E` | `#402E2E` (same) |

Overall feel: **earthy, camo, desaturated** — olive runs the show, burnt orange and gold provide the warmth.

## License

MIT License. Check the [LICENSE](LICENSE) file for more details.
