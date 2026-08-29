<h1 align="center">Lluvia Verde</h1>

<p align="center">
  A Matrix-style green rain effect for PowerShell terminals.
</p>

---

Lluvia Verde renders falling characters directly in a VT-compatible terminal and restores the original screen when the animation exits normally.

## Install

You need PowerShell and a modern terminal such as Windows Terminal or the Visual Studio Code integrated terminal.

```powershell
git clone https://github.com/delriscotechnologies/lluviaverde.git
cd lluviaverde
powershell.exe -NoProfile -File .\lluviaverde.ps1
```

## What it does

1. Creates animated columns of letters, numbers, and symbols.
2. Uses different speeds and trail lengths for each column.
3. Renders the animation in the terminal alternate screen.
4. Restores the terminal when the script exits normally.

## Output

Lluvia Verde displays the animation in the terminal. It does not create reports, logs, or other output files.

## Demo

Run the script and press Esc to exit.

```powershell
.\lluviaverde.ps1
```

Run a lighter 20-second animation:

```powershell
.\lluviaverde.ps1 -Density 30 -Fps 30 -DurationSeconds 20
```

| Option | Default | Purpose |
| --- | ---: | --- |
| `-Density` | `42` | Approximate percentage of active columns |
| `-Fps` | `60` | Target frames per second |
| `-DurationSeconds` | `0` | Automatic stop time; `0` runs until Esc |

## Scope and limits

- Terminal visual effect only.
- Requires a terminal with VT escape-sequence support.
- Does not make network requests or modify system configuration.
- Terminal behavior can vary between hosts and terminal applications.

## License

No license file is currently included in this repository.
