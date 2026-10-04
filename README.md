<h1 align="center">Lluvia Verde</h1>

<p align="center">
  A Matrix-style green rain effect for PowerShell terminals.
</p>

---

Lluvia Verde renders falling characters directly in a VT-compatible terminal and restores the original screen when the animation exits normally.

## Install

```powershell
git clone https://github.com/delriscotechnologies/lluviaverde.git
cd lluviaverde
.\lluviaverde.ps1
```

## What it does

1. Creates animated columns of letters, numbers, and symbols.
2. Uses different speeds and trail lengths for each column.
3. Renders the animation in the terminal alternate screen.
4. Restores the terminal when the animation exits.
5. Stops cleanly if the terminal is resized.

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

| Option | Default | Range | Purpose |
| --- | ---: | ---: | --- |
| `-Density` | `42` | `1–100` | Approximate percentage of active columns |
| `-Fps` | `60` | `1–120` | Target frames per second |
| `-DurationSeconds` | `0` | `0+` | Automatic stop time; `0` runs until Esc |
