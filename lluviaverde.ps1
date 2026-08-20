[CmdletBinding()]
param(
    [ValidateRange(5, 100)][int]$Density = 42,
    [ValidateRange(10, 120)][int]$Fps = 60,
    [ValidateRange(0, 3600)][int]$DurationSeconds = 0
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
if ([Console]::IsOutputRedirected) { throw 'Run lluviaverde in an interactive terminal.' }

$vt = $Host.UI.PSObject.Properties['SupportsVirtualTerminal']
if (-not ($env:WT_SESSION -or $env:TERM -or ($vt -and $vt.Value))) {
    throw 'Use Windows Terminal, the VS Code terminal, or another VT-compatible terminal.'
}

$esc = [char]27
$glyphs = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ@#$%&*+-'.ToCharArray()
$colors = @(
    "$esc[38;2;0;50;18m",
    "$esc[38;2;0;120;42m",
    "$esc[38;2;20;235;90m",
    "$esc[38;2;215;255;225m"
)
$random = [System.Random]::new()
$clock = [System.Diagnostics.Stopwatch]::StartNew()
$frameTime = 1.0 / $Fps
$width = [Console]::WindowWidth - 1
$height = [Console]::WindowHeight
if ($width -lt 20 -or $height -lt 8) { throw 'The terminal is too small.' }

$heads = [double[]]::new($width)
$speeds = [double[]]::new($width)
$lengths = [int[]]::new($width)
$active = [bool[]]::new($width)
$generation = [int[]]::new($width)
$minimum = [Math]::Max(4, [int]($height * 0.18))
$maximum = [Math]::Max($minimum + 1, [int]($height * 0.55))

for ($column = 0; $column -lt $width; $column++) {
    $heads[$column] = $random.Next(-$height, $height)
    $speeds[$column] = 5.5 + ($random.NextDouble() * 9.5)
    $lengths[$column] = $random.Next($minimum, $maximum)
    $active[$column] = $random.Next(1, 101) -le $Density
    $generation[$column] = $random.Next(0, $glyphs.Length)
}

$started = $clock.Elapsed.TotalSeconds
$previous = $started
$nextFrame = $started

try {
    [Console]::Write("$esc[?1049h$esc[?25l$esc[2J")
    while ($true) {
        $now = $clock.Elapsed.TotalSeconds
        if ($DurationSeconds -and ($now - $started) -ge $DurationSeconds) { break }
        if (-not [Console]::IsInputRedirected -and [Console]::KeyAvailable -and
            [Console]::ReadKey($true).Key -eq [ConsoleKey]::Escape) { break }

        $delta = [Math]::Min(0.25, $now - $previous)
        $previous = $now
        $frame = [System.Text.StringBuilder]::new()

        for ($column = 0; $column -lt $width; $column++) {
            if (-not $active[$column]) { continue }
            $oldHead = [int][Math]::Floor($heads[$column])
            $heads[$column] += $speeds[$column] * $delta
            $head = [int][Math]::Floor($heads[$column])
            $length = $lengths[$column]
            if ($head -eq $oldHead) { continue }

            for ($row = $oldHead - $length; $row -lt $head - $length; $row++) {
                if ($row -ge 0 -and $row -lt $height) {
                    [void]$frame.Append("$esc[$($row + 1);$($column + 1)H ")
                }
            }

            for ($distance = $length - 1; $distance -ge 0; $distance--) {
                $row = $head - $distance
                if ($row -lt 0 -or $row -ge $height) { continue }
                $ratio = $distance / [double]$length
                $level = if ($distance -eq 0) { 3 } elseif ($ratio -lt 0.16) { 2 } elseif ($ratio -lt 0.48) { 1 } else { 0 }
                $index = ($column * 17 + $row * 31 + $generation[$column] * 13) % $glyphs.Length
                [void]$frame.Append("$esc[$($row + 1);$($column + 1)H$($colors[$level])$($glyphs[$index])")
            }

            if (($head - $length) -gt $height) {
                $heads[$column] = -$random.Next(2, $height * 2)
                $speeds[$column] = 5.5 + ($random.NextDouble() * 9.5)
                $generation[$column]++
            }
        }

        [Console]::Write($frame.ToString())
        $nextFrame += $frameTime
        $wait = ($nextFrame - $clock.Elapsed.TotalSeconds) * 1000
        if ($wait -gt 3) { [Threading.Thread]::Sleep([int]($wait - 2)) }
        while ($clock.Elapsed.TotalSeconds -lt $nextFrame) { }
        if (($clock.Elapsed.TotalSeconds - $nextFrame) -gt $frameTime) { $nextFrame = $clock.Elapsed.TotalSeconds }
    }
} finally {
    [Console]::Write("$esc[0m$esc[?25h$esc[?1049l")
}

