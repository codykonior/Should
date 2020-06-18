Describe "Should" {
    $ErrorActionPreference = "Stop"
    Set-StrictMode -Version Latest
    Import-Module C:\Git\Should\Should -Force

    function Get-Transcript {
        [CmdletBinding()]
        param (
            [Parameter(Mandatory)]
            [ValidateNotNullOrEmpty()]
            $FileName
        )

        begin {

        }
        process {
            $content = Get-Content $FileName -Raw
            # Skip the first two sets of stars, then copy everything to the end
            if ($content -match "(?s)\*{22}.*?\*{22}(.*)") {
                $Matches[1]
            } else {
                Write-Error "Transcript incorrect $FileName"
            }
        }
        end {

        }
    }

    $scriptFile = [System.IO.Path]::GetTempFileName() + ".ps1"
    $outputFile = [System.IO.Path]::GetTempFileName()

    $parameters = @(
        '""',
        '$null',
        '"A"',

        '"" $null',
        '"" ""',
        '$null $null',
        '$null ""',

        '"" "B"',
        '$null "B"',

        '"A" "B"'
    )

    foreach ($parameter in $parameters) {
        It "Read-ShouldContinue -Query -Caption should match with parameters $parameter" {
            Set-Content $scriptFile "dir c:\"

            &cmd /c powershell.exe -File $scriptFile > $outputFile

            $scriptBlock = [scriptblock]::Create("function Test { FunctionName -WhatIf $parameter; FunctionName $parameter; FunctionName -Confirm:`$false $parameter; FunctionName -Confirm $parameter; }")
            $ExecutionContext.InvokeCommand.InvokeScript($false, $scriptBlock, $null, $null)

            function FunctionName { [CmdletBinding(SupportsShouldProcess)] param([string] $Query, [string] $Caption) $PSCmdlet.ShouldContinue($Query, $Caption) }
            Start-Transcript $tempFileOriginal
            Test
            Stop-Transcript
            $original = Get-Transcript $tempFileOriginal
            Write-Verbose "Original $tempFileOriginal" -Verbose
            $original | Write-Verbose -Verbose

            function FunctionName { [CmdletBinding(SupportsShouldProcess)] param([string] $Query, [string] $Caption) Read-ShouldContinue -Query $Query -Caption $Caption }
            Start-Transcript $tempFileNew
            Test
            Stop-Transcript
            $new = Get-Transcript $tempFileNew
            Write-Verbose "New $tempFileNew" -Verbose
            $new | Write-Verbose -Verbose

            $original | Should -eq $new
        }
    }
}
