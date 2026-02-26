$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing

$base = Join-Path $PSScriptRoot '..\assets\images\favicon'
$base = [System.IO.Path]::GetFullPath($base)

function To-Single([double]$value) {
  return [single]$value
}

function New-RoundedRectPath {
  param(
    [System.Drawing.Rectangle]$Rect,
    [int]$Radius
  )

  $path = New-Object System.Drawing.Drawing2D.GraphicsPath
  $diameter = $Radius * 2
  $path.AddArc($Rect.X, $Rect.Y, $diameter, $diameter, 180, 90)
  $path.AddArc($Rect.Right - $diameter, $Rect.Y, $diameter, $diameter, 270, 90)
  $path.AddArc($Rect.Right - $diameter, $Rect.Bottom - $diameter, $diameter, $diameter, 0, 90)
  $path.AddArc($Rect.X, $Rect.Bottom - $diameter, $diameter, $diameter, 90, 90)
  $path.CloseFigure()
  return $path
}

function New-HolIcon {
  param(
    [int]$IconSize,
    [string]$OutputPath
  )

  $IconSize = [int](@($IconSize)[0])

  $bitmap = New-Object System.Drawing.Bitmap($IconSize, $IconSize, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
  $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
  $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
  $graphics.Clear([System.Drawing.Color]::Transparent)

  $padding = [int][Math]::Round(($IconSize * 0.08))
  if ($padding -lt 1) { $padding = 1 }
  $innerSize = [int]$IconSize - ([int]$padding * 2)
  $rect = New-Object System.Drawing.Rectangle([int]$padding, [int]$padding, [int]$innerSize, [int]$innerSize)
  $radius = [int][Math]::Round(($IconSize * 0.18))
  if ($radius -lt 2) { $radius = 2 }
  $backgroundPath = New-RoundedRectPath -Rect $rect -Radius $radius

  $startColor = [System.Drawing.ColorTranslator]::FromHtml('#01A982')
  $endColor = [System.Drawing.ColorTranslator]::FromHtml('#0B5D50')
  $backgroundBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush($rect, $startColor, $endColor, 45.0)
  $graphics.FillPath($backgroundBrush, $backgroundPath)

  $borderPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(220, 255, 255, 255), [Math]::Max([single]($IconSize * 0.03), 1.0))
  $graphics.DrawPath($borderPen, $backgroundPath)

  $scale = $IconSize / 512.0
  function S([double]$value) { return [single]($value * $scale) }

  $flaskPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(245, 255, 255, 255), [Math]::Max([single]($IconSize * (22.0 / 512.0)), 1.2))
  $flaskPen.LineJoin = [System.Drawing.Drawing2D.LineJoin]::Round
  $flaskPen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
  $flaskPen.EndCap = [System.Drawing.Drawing2D.LineCap]::Round

  $graphics.DrawLine($flaskPen, (S 220), (S 150), (S 292), (S 150))

  $flaskPath = New-Object System.Drawing.Drawing2D.GraphicsPath
  $flaskPath.StartFigure()
  $flaskPath.AddLine((S 230), (S 150), (S 230), (S 202))
  $flaskPath.AddLine((S 230), (S 202), (S 152), (S 342))
  $flaskPath.AddBezier((S 152), (S 342), (S 137), (S 370), (S 158), (S 404), (S 190), (S 404))
  $flaskPath.AddLine((S 190), (S 404), (S 322), (S 404))
  $flaskPath.AddBezier((S 322), (S 404), (S 354), (S 404), (S 375), (S 370), (S 360), (S 342))
  $flaskPath.AddLine((S 360), (S 342), (S 282), (S 202))
  $flaskPath.AddLine((S 282), (S 202), (S 282), (S 150))
  $graphics.DrawPath($flaskPen, $flaskPath)

  $liquidBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(166, 0, 31, 26))
  $graphics.FillEllipse($liquidBrush, (S 186), (S 298), (S 140), (S 60))

  $bubbleBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(230, 255, 255, 255))
  $graphics.FillEllipse($bubbleBrush, (S 209), (S 257), (S 22), (S 22))
  $graphics.FillEllipse($bubbleBrush, (S 283), (S 233), (S 18), (S 18))

  $bitmap.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Png)

  $bubbleBrush.Dispose()
  $liquidBrush.Dispose()
  $flaskPen.Dispose()
  $flaskPath.Dispose()
  $borderPen.Dispose()
  $backgroundBrush.Dispose()
  $backgroundPath.Dispose()
  $graphics.Dispose()
  $bitmap.Dispose()
}

$targets = @(
  [pscustomobject]@{ IconSize = 16; Name = 'favicon-16x16.png' },
  [pscustomobject]@{ IconSize = 32; Name = 'favicon-32x32.png' },
  [pscustomobject]@{ IconSize = 180; Name = 'apple-touch-icon.png' },
  [pscustomobject]@{ IconSize = 192; Name = 'android-chrome-192x192.png' },
  [pscustomobject]@{ IconSize = 512; Name = 'android-chrome-512x512.png' }
)

foreach ($target in $targets) {
  $output = Join-Path $base $target.Name
  New-HolIcon -IconSize $target.IconSize -OutputPath $output
}

$iconPngPath = Join-Path $base 'favicon-32x32.png'
$icoPath = Join-Path $base 'favicon.ico'
$bitmap32 = New-Object System.Drawing.Bitmap($iconPngPath)
$icon = [System.Drawing.Icon]::FromHandle($bitmap32.GetHicon())
$stream = [System.IO.File]::Open($icoPath, [System.IO.FileMode]::Create)
$icon.Save($stream)
$stream.Close()
$icon.Dispose()
$bitmap32.Dispose()

Write-Host 'Favicon set generated:'
$targets.Name | ForEach-Object { Write-Host " - $_" }
Write-Host ' - favicon.ico'
