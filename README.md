<h1 align="center">lluviaverde</h1>

<p align="center">
  A smooth Matrix-style green rain effect for PowerShell terminals.
</p>

---

`lluviaverde` is one PowerShell script that draws animated green digital rain directly in a VT-compatible terminal. It uses the terminal's alternate screen and restores the original screen when it exits normally.

## Quick Start

You need Windows PowerShell 5.1 or PowerShell 7 and a modern terminal such as Windows Terminal or the Visual Studio Code integrated terminal.

```powershell
git clone https://github.com/delriscotechnologies/lluviaverde.git
cd lluviaverde
powershell.exe -NoProfile -File .\lluviaverde.ps1
```

Press `Esc` to exit. If PowerShell blocks the script, follow your organization's approved execution-policy and code-signing requirements.

## Options

```powershell
.\lluviaverde.ps1 -Density 55 -Fps 60 -DurationSeconds 30
```

| Option | Range | Default | Purpose |
| --- | ---: | ---: | --- |
| `Density` | 5-100 | 42 | Percentage of active rain columns |
| `Fps` | 10-120 | 60 | Target frame rate |
| `DurationSeconds` | 0-3600 | 0 | Runtime in seconds; `0` runs until `Esc` |

The requested frame rate is a target. Actual smoothness depends on terminal size, terminal renderer, system load, and hardware.

## Safety and Privacy

- Runs locally and writes only to the active terminal session.
- Does not use the network, collect credentials, or launch other processes.
- Does not write files or modify the Windows registry.
- Validates all command-line values before starting the animation.

See [SECURITY.md](SECURITY.md) for security and vulnerability-reporting guidance.

