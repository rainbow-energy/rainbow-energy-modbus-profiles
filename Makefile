.PHONY: help pull check check-profile

CLIENT_IMAGE ?= ghcr.io/rainbow-energy/rainbow-energy-modbus-client:latest
PROFILES_MOUNT = -v "$(CURDIR):/profiles:ro" -w /profiles
CLIENT = docker run --rm $(PROFILES_MOUNT) $(CLIENT_IMAGE)

help:
	@printf '%s\n' \
		"make pull          Pull the client CLI image from GHCR" \
		"make check         Validate all profiles/*.yaml" \
		"make check-profile Validate one profile (PROFILE=profiles/foo.yaml)"

pull:
	docker pull $(CLIENT_IMAGE)

check:
	@test $$(find profiles -maxdepth 1 -name '*.yaml' 2>/dev/null | wc -l | tr -d ' ') -gt 0 \
		|| (echo "No profile YAML files in profiles/" >&2; exit 1)
	@for f in $$(find profiles -maxdepth 1 -name '*.yaml' | sort); do \
		echo "Checking $$f..."; \
		$(CLIENT) check-profile "$$f" || exit $$?; \
	done

check-profile:
	@test -n "$(PROFILE)" || (echo "Usage: make check-profile PROFILE=profiles/foo.yaml" >&2; exit 2)
	$(CLIENT) check-profile "$(PROFILE)"
