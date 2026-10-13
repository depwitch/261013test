$utf8 = New-Object System.Text.UTF8Encoding($false)
$dir = $PSScriptRoot

$tpl = [System.IO.File]::ReadAllText("$dir\template.html", $utf8)
$css = [System.IO.File]::ReadAllText("$dir\css\style.css", $utf8)
$data = [System.IO.File]::ReadAllText("$dir\js\data.js", $utf8)
$sound = [System.IO.File]::ReadAllText("$dir\js\sound.js", $utf8)
$storage = [System.IO.File]::ReadAllText("$dir\js\storage.js", $utf8)
$charts = [System.IO.File]::ReadAllText("$dir\js\charts.js", $utf8)
$ai = [System.IO.File]::ReadAllText("$dir\js\ai-tutor.js", $utf8)
$app = [System.IO.File]::ReadAllText("$dir\js\app.js", $utf8)

$extraCss = @"
.brand-logo-wrap {
  width: 44px;
  height: 44px;
  border-radius: var(--radius-md);
  overflow: hidden;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, rgba(14, 165, 233, 0.25), rgba(16, 185, 129, 0.25));
  border: 1px solid rgba(56, 189, 248, 0.35);
  box-shadow: 0 4px 14px var(--glow-cyan);
  flex-shrink: 0;
}
.brand-logo-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.brand-logo-fallback {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
}
"@

$combinedCss = $css + [Environment]::NewLine + $extraCss
$combinedJs = $data + [Environment]::NewLine + $sound + [Environment]::NewLine + $storage + [Environment]::NewLine + $charts + [Environment]::NewLine + $ai + [Environment]::NewLine + $app

$out = $tpl.Replace("/* CSS_INLINE_PLACEHOLDER */", $combinedCss)
$out = $out.Replace("/* JS_INLINE_PLACEHOLDER */", $combinedJs)

[System.IO.File]::WriteAllText("$dir\index.html", $out, $utf8)
Write-Output "SUCCESS: Inlined index.html generated with length $($out.Length)"
