#!/bin/bash
acorn build -t ghcr.io/randall-coding/acorn/mediawiki && \
acorn push ghcr.io/randall-coding/acorn/mediawiki && \
acorn run -s mediawiki:mediawiki -n mediawiki --memory=1Gi ghcr.io/randall-coding/acorn/mediawiki
