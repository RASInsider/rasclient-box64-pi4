# Validation record — Raspberry Pi 4

## Test platform

- Raspberry Pi OS Trixie ARM64
- Raspberry Pi 4 profile (`bcm2711`)
- Box64 ARM64 dynarec build
- Parallels RAS Linux Client 22.0.28160 amd64 package supplied by the operator
- RAS 22 laboratory Gateway over SSL

## Observed results

1. `appserverclient --help` executed successfully under Box64.
2. The Qt6/XCB graphical client started after providing an isolated amd64
   userspace library root.
3. The client displayed the RAS connection dialog.
4. The Gateway connection completed interactively.
5. Published resources were listed by the client.
6. Notepad launched as a published Windows application.

## Non-results

This is not a support statement from Parallels. No claim is made for other Pi
models, native ARM64 operation, production readiness, or long-term compatibility
with future Parallels releases.

## Reproducibility

The original official client package is an input supplied by the operator and
is deliberately excluded from Git. The build scripts create the Box64 runtime,
download the required amd64 runtime libraries into a private root, and package
the local client for the target Pi.
