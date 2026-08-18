# Routine: Read status file and report
# FIXED VERSION - correctly exits with error when file not found

$statusFile = "status.txt"

Write-Host "=== Routine Check Started ==="
Write-Host "Reading $statusFile..."

if (Test-Path $statusFile) {
    $content = Get-Content $statusFile -Raw
    Write-Host "File contents:"
    Write-Host $content

    # Check if it contains SUCCESS
    if ($content -match "SUCCESS") {
        Write-Host "Check PASSED: Found SUCCESS marker"
        exit 0
    } else {
        Write-Host "Check FAILED: No SUCCESS marker found"
        exit 1
    }
} else {
    Write-Host "ERROR: File not found: $statusFile"
    Write-Host "Check FAILED: Cannot verify status"
    exit 1  # FIXED: Now correctly returns failure
}
