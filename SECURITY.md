# Security Policy

## Supported Version

Security fixes are applied to the latest version on the `main` branch.

## Reporting a Vulnerability

Use GitHub private vulnerability reporting from the repository's **Security** tab when available. Do not include credentials, tokens, private system details, or other sensitive data in a public issue.

Include the affected version, reproduction steps, expected behavior, actual behavior, and potential impact.

## Security Model

`lluviaverde` is a local terminal animation. The script:

- writes ANSI/VT escape sequences and generated characters only to the active terminal
- does not request, store, or transmit credentials or tokens
- does not access the network
- does not write files or modify the Windows registry
- does not launch child processes, request elevation, or evaluate dynamically constructed code
- restores the cursor and original terminal screen in a `finally` block during normal exit and handled interruption

## Operational Guidance

Review downloaded scripts before running them and use a trusted PowerShell host. Follow your organization's execution-policy and code-signing requirements.

Press `Esc` to exit cleanly. Forcefully terminating PowerShell or the terminal can prevent cleanup from running; reopen the terminal if its display state remains altered.

The configured frame rate is a target rather than a real-time guarantee. Terminal size, renderer performance, hardware, and system load affect the achieved frame rate.

