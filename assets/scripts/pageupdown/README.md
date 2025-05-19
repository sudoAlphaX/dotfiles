# PageUpDown

Swap PageUp and PageDown keys

## Dependencies

- [Interception Tools][interception-tools]

## Building

```text
cd pageupdown
make build
sudo make install
```

## Execution

```text
pageupdown - Swap PageUp and PageDown keys

usage: pageupdown [-h]
```

`pageupdown` is an [_Interception Tools_][interception-tools] plugin. A suggested
`udevmon` job configuration (check the [_Interception Tools_
README][interception-tools] for alternatives) is:

```yaml
- JOB: intercept -g $DEVNODE | pageupdown | uinput -d $DEVNODE
  DEVICE:
    EVENTS:
      EV_KEY: [KEY_PAGEUP, KEY_PAGEDOWN]
```

For more information about the [_Interception Tools_][interception-tools], check
the project's website.

## Caveats

As always, there's always a caveat:

- `intercept -g` will "grab" the detected devices for exclusive access.
- If you tweak your key repeat settings, check whether they get reset.
  Please check [this report][key-repeat-fix] about the resolution.

## History

Just forked this project and modified it to swap PageUp and PageDown keys.

- <https://github.com/alexandre/caps2esc>

## License

MIT License
Copyright © 2025 Alpha

[interception-tools]: https://gitlab.com/interception/linux/tools
[key-repeat-fix]: https://github.com/oblitum/caps2esc/issues/1
