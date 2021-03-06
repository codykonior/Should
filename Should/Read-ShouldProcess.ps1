<#

.SYNOPSIS


.DESCRIPTION

# .PARAMETER

.NOTES

- Cannot support ShouldProcess with YesToAll/NoToAll where there's no YesToAll and NoToAll provided.
- You can't specify Mandatory on the below parameters because it makes it work less like the original in regards to accepting $null.

Constructors emulated:

    bool ShouldProcess(string target)
    bool ShouldProcess(string target, string action)
    bool ShouldProcess(string verboseDescription, string verboseWarning, string caption)
    bool ShouldProcess(string verboseDescription, string verboseWarning, string caption, [ref] System.Management.Automation.ShouldProcessReason shouldProcessReason)

Tests:

    function FunctionName { [CmdletBinding(SupportsShouldProcess)] param([string] $Target) $PSCmdlet.ShouldProcess($Target) }
    function Test { FunctionName -WhatIf; FunctionName; FunctionName -Confirm; } Test
    function FunctionName { [CmdletBinding(SupportsShouldProcess)] param([string] $Target) Read-ShouldProcess -Target $Target }
    function Test { FunctionName -WhatIf; FunctionName; FunctionName -Confirm; } Test
    #--
    function FunctionName { [CmdletBinding(SupportsShouldProcess)] param([string] $Target) $PSCmdlet.ShouldProcess($Target) }
    function Test { FunctionName -WhatIf $null; FunctionName -Confirm $null; } Test
    function FunctionName { [CmdletBinding(SupportsShouldProcess)] param([string] $Target) Read-ShouldProcess -Target $Target }
    function Test { FunctionName -WhatIf $null; FunctionName -Confirm $null; } Test
    #--
    function FunctionName { [CmdletBinding(SupportsShouldProcess)] param([string] $Target) $PSCmdlet.ShouldProcess($Target) }
    function Test { FunctionName -WhatIf ""; FunctionName -Confirm ""; } Test
    function FunctionName { [CmdletBinding(SupportsShouldProcess)] param([string] $Target) Read-ShouldProcess -Target $Target }
    function Test { FunctionName -WhatIf ""; FunctionName -Confirm ""; } Test
    #----
    function FunctionName { [CmdletBinding(SupportsShouldProcess)] param([string] $Target) $PSCmdlet.ShouldProcess($Target) }
    function Test { FunctionName -WhatIf A; FunctionName -Confirm A } Test
    function FunctionName { [CmdletBinding(SupportsShouldProcess)] param([string] $Target) Read-ShouldProcess -Target $Target }
    function Test { FunctionName -WhatIf A; FunctionName -Confirm A } Test
    #--
    function FunctionName { [CmdletBinding(SupportsShouldProcess)] param([string] $Target, [string] $Action) $PSCmdlet.ShouldProcess($Target, $Action) }
    function Test { FunctionName -WhatIf A B; FunctionName -Confirm A B } Test
    function FunctionName { [CmdletBinding(SupportsShouldProcess)] param([string] $Target, [string] $Action) Read-ShouldProcess -Target $Target -Action $Action }
    function Test { FunctionName -WhatIf A B; FunctionName -Confirm A B } Test
    #----
    function FunctionName { [CmdletBinding(SupportsShouldProcess)] param([string] $VerboseDescription, [string] $VerboseWarning, [string] $Caption) $PSCmdlet.ShouldProcess($VerboseDescription, $VerboseWarning, $Caption) }
    function Test { FunctionName -WhatIf A B; FunctionName -Confirm A B } Test
    function FunctionName { [CmdletBinding(SupportsShouldProcess)] param([string] $VerboseDescription, [string] $VerboseWarning, [string] $Caption) Read-ShouldProcess -VerboseDescription $VerboseDescription -VerboseWarning $VerboseWarning -Caption $Caption }
    function Test { FunctionName -WhatIf A B; FunctionName -Confirm A B } Test
    #--
    function FunctionName { [CmdletBinding(SupportsShouldProcess)] param([string] $VerboseDescription, [string] $VerboseWarning, [string] $Caption) $PSCmdlet.ShouldProcess($VerboseDescription, $VerboseWarning, $Caption) }
    function Test { FunctionName -WhatIf A B C; FunctionName -Confirm A B C } Test
    function FunctionName { [CmdletBinding(SupportsShouldProcess)] param([string] $VerboseDescription, [string] $VerboseWarning, [string] $Caption) Read-ShouldProcess -VerboseDescription $VerboseDescription -VerboseWarning $VerboseWarning -Caption $Caption }
    function Test { FunctionName -WhatIf A B C; FunctionName -Confirm A B C } Test
    #--
    function FunctionName { [CmdletBinding(SupportsShouldProcess)] param([string] $VerboseDescription, [string] $VerboseWarning, [string] $Caption) $PSCmdlet.ShouldProcess($VerboseDescription, $VerboseWarning, $Caption) }
    function Test { FunctionName -WhatIf $null $null C; FunctionName -Confirm $null $null C } Test
    function FunctionName { [CmdletBinding(SupportsShouldProcess)] param([string] $VerboseDescription, [string] $VerboseWarning, [string] $Caption) Read-ShouldProcess -VerboseDescription $VerboseDescription -VerboseWarning $VerboseWarning -Caption $Caption }
    function Test { FunctionName -WhatIf $null $null C; FunctionName -Confirm $null $null C } Test
    #--
    function FunctionName { [CmdletBinding(SupportsShouldProcess)] param([string] $VerboseDescription, [string] $VerboseWarning, [string] $Caption) $PSCmdlet.ShouldProcess($VerboseDescription, $VerboseWarning, $Caption) }
    function Test { FunctionName -WhatIf $null $null $null; FunctionName -Confirm $null $null $null } Test
    function FunctionName { [CmdletBinding(SupportsShouldProcess)] param([string] $VerboseDescription, [string] $VerboseWarning, [string] $Caption) Read-ShouldProcess -VerboseDescription $VerboseDescription -VerboseWarning $VerboseWarning -Caption $Caption }
    function Test { FunctionName -WhatIf $null $null $null; FunctionName -Confirm $null $null $null } Test

Source

    https://github.com/PowerShell/PowerShell/blob/aa07eef187abee664cd2705336f8aac8de4e27e2/src/System.Management.Automation/engine/MshCommandRuntime.cs
    private bool ShouldProcess
    private bool DoShouldProcess

SupportsVirtualTerminal verification code for Normal, Start-Job, Start-RSJob, Invoke-Command, Invoke-Command -ComputerName, Workflow, and Enter-PSSession

    if ($Host.UI.SupportsVirtualTerminal -and (Read-Host "Normal Test")) { "Normal Test Ok" } else { "Normal Test Ok" }
    Start-Job { if ($Host.UI.SupportsVirtualTerminal -and (Read-Host "Start-Job Test")) { "Start-Job Test Ok" } else { "Start-Job Test Ok" } } | Wait-Job | Receive-Job
    Start-RSJob { if ($Host.UI.SupportsVirtualTerminal -and (Read-Host "Start-RSJob Test")) { "Start-RSJob Test Ok" } else { "Start-RSJob Test Ok" } } | Wait-RSJob | Receive-RSJob
    Invoke-Command { if ($Host.UI.SupportsVirtualTerminal -and (Read-Host "Invoke-Command Test")) { "Invoke-Command Test Ok" } else { "Invoke-Command Test Ok" } }
    Invoke-Command -ComputerName . { if ($Host.UI.SupportsVirtualTerminal -and (Read-Host "Invoke-Command -ComputerName Test")) { "Invoke-Command -ComputerName Test Ok" } else { "Invoke-Command -ComputerName Test Ok" } }
    workflow TestWorkFlow { if ($Host.UI.SupportsVirtualTerminal -and (Read-Host "Workflow Test")) { "Workflow Test Ok" } else { "Workflow Test Ok" } }; TestWorkflow
    Enter-PSSession -ComputerName .
    if ($Host.UI.SupportsVirtualTerminal -and (Read-Host "Enter-PSSession Test")) { "Enter-PSSession Test Ok" } else { "Enter-PSSession Test Ok" }
    Exit-PSSession

#>

function Read-ShouldProcess {
    [CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = "Target")]
    param (
        [Parameter(Position = 0, ParameterSetName = "Target")]
        [string] $Target,
        [Parameter(Position = 1, ParameterSetName = "Target")]
        [string] $Action,

        [Parameter(Position = 0, ParameterSetName = "Verbose")]
        [string] $VerboseDescription,
        [Parameter(Position = 1, ParameterSetName = "Verbose")]
        [string] $VerboseWarning,
        [Parameter(Position = 2, ParameterSetName = "Verbose")]
        [string] $Caption,

        [Parameter(Position = 3, ParameterSetName = "Verbose")]
        [Parameter(ParameterSetName = "Target")]
        [ref] $ShouldProcessReason,
        [Parameter(ParameterSetName = "Verbose")]
        [Parameter(ParameterSetName = "Target")]
        [ref] [bool] $YesToAll,
        [Parameter(ParameterSetName = "Verbose")]
        [Parameter(ParameterSetName = "Target")]
        [ref] [bool] $NoToAll,
        [Parameter(ParameterSetName = "Verbose")]
        [Parameter(ParameterSetName = "Target")]
        [switch] $HasSecurityImpact,
        [Parameter(ParameterSetName = "Verbose")]
        [Parameter(ParameterSetName = "Target")]
        [scriptblock] $Retry
    )

    begin {
    }

    process {
        $callerFunctionName = (Get-PSCallStack)[1].Command

        if (-not $WhatIfPreference) {
            # Testing shows NoToAll is used before YesToAll
            if ($NoToAll -and $NoToAll.Value -eq $true) {
                return $false
            } elseif ($YesToAll -and $YesToAll.Value -eq $true) {
                return $true
            }

            # If it's None/Low/Medium
            $confirmImpact = if (Test-Path function:$callerFunctionName) {
                ((Get-Command $callerFunctionName).ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletCommonMetadataAttribute] }).ConfirmImpact
            } else {
                Write-Debug "ConfirmImpact defaulting to Medium"
                [System.Management.Automation.ConfirmImpact] "Medium"
            }
            Write-Debug "ConfirmImpact $confirmImpact ConfirmPreference $ConfirmPreference"
            if ($ConfirmPreference -eq 0 -or $ConfirmPreference -gt $confirmImpact) {
                # Then we won't confirm anything
                if ($HasSecurityImpact) {
                    return $false
                } else {
                    return $true
                }
            }
        }

        $choices = New-Object System.Collections.ObjectModel.Collection[System.Management.Automation.Host.ChoiceDescription]
        $choices.Add((New-Object System.Management.Automation.Host.ChoiceDescription("&Yes", "Continue with only the next step of the operation.")))
        if ($YesToAll) {
            $choices.Add((New-Object System.Management.Automation.Host.ChoiceDescription("Yes to &All", "Continue with all the steps of the operation.")))
        }
        $choices.Add((New-Object System.Management.Automation.Host.ChoiceDescription("&No", "Skip this operation and proceed with the next operation.")))
        if ($NoToAll) {
            $choices.Add((New-Object System.Management.Automation.Host.ChoiceDescription("No to A&ll", "Skip this operation and all subsequent operations.")))
        }
        $choices.Add((New-Object System.Management.Automation.Host.ChoiceDescription("&Suspend", "Pause the current pipeline and return to the command prompt. Type `"exit`" to resume the pipeline.")))
        if ($Retry) {
            $choices.Add((New-Object System.Management.Automation.Host.ChoiceDescription("&Retry", "Retry an operation.")))
        }

        $defaultChoice = if (-not $HasSecurityImpact) {
            $choices.IndexOf(($choices | Where-Object { $_.Label.Replace("&", "") -eq "Yes" }))
        } else {
            $choices.IndexOf(($choices | Where-Object { $_.Label.Replace("&", "") -eq "No" }))
        }

        if ($ShouldProcessReason -and $WhatIfPreference) {
            $ShouldProcessReason.Value = [System.Management.Automation.ShouldProcessReason] "WhatIf"
        } else {
            $ShouldProcessReason = [ref] (New-Object System.Management.Automation.ShouldProcessReason)
            $ShouldProcessReason.Value = [System.Management.Automation.ShouldProcessReason] "None"
        }

        do {
            $exit = $true

            $selection = if ($Host.UI.SupportsVirtualTerminal) {
                $promptCaption = ""
                $promptMessage = ""

                if ($PSCmdlet.ParameterSetName -eq "Target") {
                    if (-not $PSBoundParameters["Action"]) {
                        $Action = $callerFunctionName
                    }

                    if ($WhatIfPreference) {
                        Write-Information "What if: Performing the operation `"$Action`" on target `"$Target`"." -InformationAction:Continue
                        return
                    } else {
                        Write-Host ""
                        Write-Host "Confirm" -ForegroundColor White -NoNewLine

                        $promptCaption = "Are you sure you want to perform this action?"
                        $promptMessage = "Performing the operation `"$Action`" on target `"$Target`"."
                    }
                } elseif ($PSCmdlet.ParameterSetName -eq "Verbose") {
                    if (-not $PSBoundParameters["Caption"]) {
                        $Caption = "Confirm"
                    }
                    if (-not $PSBoundParameters["VerboseWarning"]) {
                        $VerboseWarning = "Are you sure you want to perform this action?"
                    }

                    if ($WhatIfPreference) {
                        Write-Information "What if: $VerboseDescription" -InformationAction:Continue
                        return
                    } else {
                        Write-Host ""
                        Write-Host $Caption -ForegroundColor White -NoNewLine

                        $promptCaption = $VerboseWarning
                        $promptMessage = $null
                    }
                } elseif ($PSCmdlet.ParameterSetName -eq "Query") {
                    if (-not $PSBoundParameters["Caption"]) {
                        $Caption = "Confirm"
                    }

                    # This is our own invention, so who knows what it should look like
                    if ($WhatIfPreference) {
                        Write-Information "What if: $Query" -InformationAction:Continue
                        return
                    }

                    if (-not $PSBoundParameters["Query"]) {
                        $Query = "Continue with this operation?"
                    }

                    $promptCaption = $Caption
                    $promptMessage = $Query
                }

                $Host.UI.PromptForChoice($promptCaption, $promptMessage, $choices, $defaultChoice)
            } else {
                $defaultChoice
            }

            $selection = $choices[$selection].Label.Replace("&", "")
            switch ($selection) {
                "Yes" {
                    $true
                }
                "Yes to All" {
                    if ($YesToAll) {
                        $YesToAll.Value = $true
                    }
                    $true
                }
                "No" {
                    $false
                }
                "No to All" {
                    if ($NoToAll) {
                        $NoToAll.Value = $true
                    }
                    $false
                }
                "Suspend" {
                    $host.EnterNestedPrompt()
                    $exit = $false
                }
                "Retry" {
                    $retrySuccess = $Retry.Invoke()
                    if (-not $succretrySuccessess) {
                        $exit = $false
                    }
                }
            }
        } until ($exit)
    }

    end {
    }
}
