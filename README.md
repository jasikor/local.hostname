# local.hostname

An [Omarchy](https://omarchy.org/) shell bar widget that shows the machine's
hostname in the bar, so you can tell which machine you're looking at
(handy behind a KVM). It reuses the bar's own font and colour, so it adds no
new theme colours by default.

- Auto-reads `/etc/hostname` (falls back to `$HOSTNAME`).
- Works on horizontal and vertical bars. On vertical bars the label is
  rotated (or stacked upright, see `mode`).
- Fully configurable per machine (label, padding, weight, size, colour).

## Install

```bash
git clone https://github.com/jasikor/local.hostname.git \
  ~/.config/omarchy/plugins/local.hostname

omarchy plugin enable local.hostname
omarchy bar put local.hostname --after omarchy.menu   # pick any placement
omarchy restart shell
```

Or let Omarchy clone and enable it from the URL:

```bash
omarchy plugin add https://github.com/jasikor/local.hostname
```

## Configuration

All options are per-widget settings; set them with `omarchy bar set`:

```bash
omarchy bar set local.hostname <key> <value>
```

| Key        | Default            | Description                                                        |
|------------|--------------------|--------------------------------------------------------------------|
| `label`    | current hostname   | Override the displayed text (e.g. `LAB`, `HOME`).                  |
| `color`    | bar foreground     | Colour override, e.g. `#ffbf00`. Empty = inherit the bar colour.   |
| `fontSize` | theme body (12)    | Font size in px.                                                    |
| `weight`   | `bold`             | `normal`, `bold`, or `black`.                                       |
| `upper`    | `false`            | Uppercase the name (`true`/`false`).                                |
| `pad`      | `2`                | Spaces of padding added on each side of the name.                   |
| `mode`     | `rotated`          | Vertical bars only: `rotated` (head-tilt) or `stacked` (upright).   |

Examples:

```bash
omarchy bar set local.hostname color "#ffbf00"
omarchy bar set local.hostname fontSize 15
omarchy bar set local.hostname weight black
omarchy bar set local.hostname label "LAB-PC"
```

Most changes apply live within a few seconds; `omarchy restart shell` forces it.

## Removal

```bash
omarchy plugin disable local.hostname
rm -rf ~/.config/omarchy/plugins/local.hostname
```

## License

MIT
