# Rainbow Energy Modbus Profiles agent guidance

## Project context

- This repository holds YAML device register maps consumed by
  [Rainbow Energy Modbus Client](https://github.com/rainbow-energy/rainbow-energy-modbus-client)
  (`load_profile`) and [Rainbow Energy Publisher](https://github.com/rainbow-energy/rainbow-energy-publisher)
  (`profile_path`).
- Profile schema, data types, and decode rules are implemented in the client;
  do not duplicate validation logic here.
- All maps live in `profiles/` and must pass `make check` before merge to `main`.
- CI runs `make check` using the published client Docker image from GHCR.

## Development process

- Follow [PROFILES.md](PROFILES.md) when adding or changing registers.
- After editing a profile, run `make check` (must exit `0` before merge).
- The `Makefile` wraps `docker run` against the client CLI image; do not add
  `uv` or a local Python toolchain here.
- Do not add speculative registers or unrelated device models without a clear
  source map or hardware confirmation.
- Keep profile keys unique (case-insensitive) and respect address overlap rules.
- Work in progress stays on a feature branch until `make check` passes.

## Documentation

- Update [PROFILES.md](PROFILES.md) when profile schema or authoring guidance
  changes (usually in the client repo first, then synced here).
- Update [README.md](README.md) when layout, validation workflow, or consumer
  integration changes.
- Do not leave docs describing removed or outdated behaviour.

## Commit messages

- Summarize the change in a subject of about 50 characters or fewer.
- Separate the subject from an optional body with a blank line.
- Wrap body text at about 72 characters.
- Explain the problem and why the change is needed rather than how the YAML
  is structured.
- Document important side effects or unintuitive consequences.
- Put issue references at the end, for example `Resolves: #123`.

## Commands

- `make pull` — pull the client CLI image from GHCR.
- `make check` — validate all `profiles/*.yaml`.
- `make check-profile PROFILE=...` — validate one profile file.
