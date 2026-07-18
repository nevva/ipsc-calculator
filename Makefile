PORT ?= 8000

# Serve index.html locally with the browser opened automatically.
# Uses Python 3, which ships with macOS — no install, no build step.
.PHONY: dev
dev:
	@echo "Serving on http://localhost:$(PORT) — Ctrl+C to stop"
	@python3 -m webbrowser "http://localhost:$(PORT)" >/dev/null 2>&1 || true
	@python3 -m http.server $(PORT)

# Same thing in Docker (nginx). Ctrl+C to stop; --rm cleans up the container.
.PHONY: docker
docker:
	@echo "Serving on http://localhost:$(PORT) — Ctrl+C to stop"
	docker build -t ipsc-calculator .
	docker run --rm -p $(PORT):80 ipsc-calculator
