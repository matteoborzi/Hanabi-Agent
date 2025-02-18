$python = $env:CONDA_PREFIX + "\python.exe"
$epochs = 1000
$numberOfPlayers = 4

if (Test-Path -Path "game.log" -PathType Leaf) {
    Remove-Item -Path "game.log"
}

Start-Process -FilePath $python -ArgumentList "server.py", $numberOfPlayers
for ($i = 0; $i -lt $numberOfPlayers; $i++) {
    $evolve = ($i -eq 0) ? "--evolve" : ""
    $type = ($i -eq 0 -or $i -eq 1) ? "Nexto" : "Poirot"
    Start-Process -FilePath $python -ArgumentList "client.py", "--bot", $type, "--player_name", "Bot$i", "--epochs", $epochs
    Start-Sleep -Seconds 0.5
}