# Rainbow Energy Modbus Profiles

YAML register maps for inverters supported by
[Rainbow Energy Modbus Client](https://github.com/rainbow-energy/rainbow-energy-modbus-client).
Each profile describes one device model: Modbus addresses, data types, scaling,
and how decoded values are named.

## Layout

| Directory | Purpose |
|-----------|---------|
| [`profiles/`](profiles/) | Supported maps. Validated in CI on every pull request. |

See [PROFILES.md](PROFILES.md) for the profile schema, data types, decode
options, and authoring rules.

## Validate locally

Uses the [published client CLI image](https://github.com/rainbow-energy/rainbow-energy-modbus-client)
from GHCR (no Python or `uv` required):

```bash
make pull    # first time, or after a client release
make check   # validate every profile in profiles/
```

Check one file:

```bash
make check-profile PROFILE=profiles/sunsynk_8k_sg05lp1.yaml
```

Pin a specific client release:

```bash
make check CLIENT_IMAGE=ghcr.io/rainbow-energy/rainbow-energy-modbus-client:db8e245
```

Tags are `latest`, short SHA, or CalVer+SHA (for example `2026.7.28-db8e245`).

`check-profile` exit codes: `0` supported, `1` unsupported features,
`2` load/schema error. Profiles on `main` must exit `0` before merge.

## Contributing

1. Fork and branch from `main`.
2. Copy an existing profile or add a new YAML file under `profiles/`.
3. Edit following [PROFILES.md](PROFILES.md).
4. Run `make check` until exit `0`.
5. Open a pull request with a short description of the device and changes.

Keep **one clear meaning per address** (except disjoint `bitmask`s on the same
word).

Exploratory work stays on a feature branch until `make check` passes. The
`sunsynk-draft-map` branch holds an older exploratory SunSynk map for reference
while fixes land on `main`.

## License

Apache License 2.0 — see [LICENSE](LICENSE).
