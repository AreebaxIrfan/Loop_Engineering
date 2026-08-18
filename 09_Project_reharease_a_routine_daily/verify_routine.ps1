# Simple direct test
Write-Host "=== Direct Exit Code Test ===" -ForegroundColor Cyan

Write-Host "`nTest 1: With existing file"
& ./routine.ps1
Write-Host "Exit code: $LASTEXITCODE"

Write-Host "`nTest 2: With missing file"
Move-Item "status.txt" "status.txt.bak" -Force
& ./routine.ps1
$missingExitCode = $LASTEXITCODE
Move-Item "status.txt.bak" "status.txt" -Force
Write-Host "Exit code: $missingExitCode"

Write-Host "`n=== Result ==="
if ($missingExitCode -eq 1) {
    Write-Host "CORRECT: Routine returns exit code 1 when file is missing" -ForegroundColor Green
} else {
    Write-Host "WRONG: Routine returns exit code $missingExitCode when file is missing (should be 1)" -ForegroundColor Red
}
