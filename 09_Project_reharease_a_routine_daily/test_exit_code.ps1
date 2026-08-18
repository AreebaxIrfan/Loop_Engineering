# Test script to verify exit codes
Write-Host "=== Testing Exit Codes ==="

Write-Host "`nTest 1: Running routine.ps1 (should exit 0 but logically fail):"
& ./routine.ps1
$exitCode = $LASTEXITCODE
Write-Host "Exit code: $exitCode"
if ($exitCode -eq 0) {
    Write-Host "Status: GREEN"
} else {
    Write-Host "Status: RED"
}

Write-Host "`nTest 2: Comparing with a genuinely successful routine:"
$statusFile = "status.txt"
if (Test-Path $statusFile) {
    $content = Get-Content $statusFile -Raw
    if ($content -match "SUCCESS") {
        Write-Host "Exit code: 0"
        Write-Host "Status: GREEN"
        Write-Host "Result: Genuinely correct"
    }
}

Write-Host "`n=== Lesson ==="
Write-Host "Both runs show GREEN (exit code 0), but:"
Write-Host "- Run 1: File not found, logic never executed"
Write-Host "- Run 2: File found, logic executed correctly"
Write-Host "The status column cannot distinguish between them!"
