<div align="center">
  <img src="https://github.com/sxyazi/yazi/blob/main/assets/logo.png?raw=true" alt="Yazi logo" width="20%">
</div>

<h3 align="center">
	Sweet Love 2 Flavor for <a href="https://github.com/sxyazi/yazi">Yazi</a>
</h3>

## Preview

A golden-olive variation of the Sweet Love theme. Warmer, more golden accents with olive green operators and brighter green highlights.

## Installation

Copy the `sweet-love-2.yazi` directory into your Yazi flavors directory:

```sh
cp -r sweet-love-2.yazi ~/.config/yazi/flavors/
```

## Usage

Set the content of your `theme.toml` to enable it as your _dark_ flavor:

```toml
[flavor]
dark = "sweet-love-2"
```

Make sure your `theme.toml` doesn't contain anything other than `[flavor]`, unless you want to override certain styles of this flavor.

See the [Yazi flavor documentation](https://yazi-rs.github.io/docs/flavors/overview) for more details.

## Differences from Sweet Love

| Element | Sweet Love | Sweet Love 2 |
|---|---|---|
| Primary accent | `#D17B49` orange | `#AF865A` gold |
| Borders/tabs | Orange | Gold |
| CWD/links | Olive `#7B8748` | Orange `#D17B49` |
| Operators | Olive `#7B8748` | Bright olive `#647035` |
| Strings | Sage `#6D715E` | Olive `#7B8748` |
| Comments | Tan `#978965` | Slate `#535C5C` |
| Errors | Burnt orange | Rose `#775759` |
| Keywords | Dark gold `#8F6840` | Orange `#D17B49` |
| Functions | Orange | Gold |
| Classes/types | Gold `#AF865A` | Dark gold `#8F6840` |
| Surface color | `#402E2E` | `#4A3637` |

## Color Palette

Same Sweet Love palette, different role assignments.

## License

MIT License. Check the [LICENSE](LICENSE) file for more details.
