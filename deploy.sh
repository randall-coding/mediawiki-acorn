#!/bin/bash
acorn build -t ghcr.io/randall-coding/acorn/mediawiki && \
acorn push ghcr.io/randall-coding/acorn/mediawiki && \
acorn run -n mediawiki --memory=2Gi ghcr.io/randall-coding/acorn/mediawiki
