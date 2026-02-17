<#
.SYNOPSIS
Created by James Lambert 2026

.DESCRIPTION
Creates a passphrase based on the settings in the config section and words in the wordlist file.
Script outputs the phrase to screen and copies it to the clipboard.

Save wordlist.txt in c:\temp or adjust config to where you wish to store it.

.EXAMPLE

.OUTPUTS

.NOTES
#>

##############
# Start Config
##############
$Config = @{
    WordlistPath    = "c:\temp\wordlist.txt"
    PhraseLength    = 3        # Number of words to pull
    MinTotalChars   = 21       # Minimum characters the final string must have
    Separator       = "-"      # Symbol between words
    Capitalize      = $true    # True for "Word-Word", False for "word-word"
    IncludeNumber   = $true    # Adds a random number (0-99) to the end
}
##############
# End Config
##############

function Generate-SecurePassphrase {
    if (-not (Test-Path $Config.WordlistPath)) {
        Write-Host "Error: Wordlist not found at $($Config.WordlistPath)" -ForegroundColor Red
        return
    }

    $Words = Get-Content -Path $Config.WordlistPath | Where-Object { $_ -match '\S' }
    $Passphrase = ""
    $Attempts = 0

    # Keep trying until we hit the minimum character length
    do {
        $Selected = for ($i = 0; $i -lt $Config.PhraseLength; $i++) {
            $Word = ($Words | Get-Random).Trim()
            if ($Config.Capitalize) {
                (Get-Culture).TextInfo.ToTitleCase($Word.ToLower())
            } else {
                $Word.ToLower()
            }
        }

        $Passphrase = $Selected -join $Config.Separator

        # Append a number if configured
        if ($Config.IncludeNumber) {
            $Passphrase += "$(Get-Random -Minimum 0 -Maximum 100)"
        }

        $Attempts++
        if ($Attempts -gt 50) {
            Write-Host "Warning: Could not meet length requirement after 50 tries. Check your settings." -ForegroundColor Yellow
            break
        }
    } until ($Passphrase.Length -ge $Config.MinTotalChars)

    # Output results
    Write-Host "`nGenerated in $Attempts attempt(s):" -ForegroundColor Gray
    Write-Host $Passphrase -ForegroundColor Green
    $Passphrase | Set-Clipboard
    Write-Host "(Copied to clipboard - Length: $($Passphrase.Length) chars)`n" -ForegroundColor Gray
}

Generate-SecurePassphrase