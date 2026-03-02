Clear-Host

$log = [Environment]::GetFolderPath("Desktop") + "\serv_screener_log.txt"

Start-Transcript $log -Force

$bruger = [Security.Principal.WindowsIdentity]::GetCurrent()
$ret = New-Object Security.Principal.WindowsPrincipal($bruger)

if (-not $ret.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {

    Write-Host ""
    Write-Host "Koer scriptet som administrator!"
    Read-Host "Tryk Enter for at afslutte"
    Exit
}

function Service_Liste {

    #Indsaet flere/andre services, der skal tjekkes:
    $Services = @(
        "Spooler",
        "Dhcp",
        "Dnscache",
        "WinDefend",
        "LanmanWorkstation"
    )

    foreach ($service in $Services) {
        Tjek_ServiceStatus -ServiceNavn $service
    }
}

function Sektion($titel) {

    Write-Host ""
    Write-Host "========================"
    Write-Host "$titel"
    Write-Host "========================"
    Write-Host ""
}

function Tjek_ServiceStatus {
    param (
        [string]$ServiceNavn
    )

    try {
        $service = Get-Service -Name $ServiceNavn -ErrorAction Stop
    }

    catch {
        Write-Host "Service $ServiceNavn findes ikke" -ForegroundColor Red
        return
    }

    if ($service.Status -eq "Running") {
        Write-Host "$ServiceNavn koerer" -ForegroundColor Green
    }

    else {

        Write-Host "$ServiceNavn er stoppet. Tjekker om $ServiceNavn skal genstartes..." -ForegroundColor Yellow
    
        if ($service.StartType -eq "Automatic") {

            Try {

                Start-Service -Name $ServiceNavn -ErrorAction Stop

                if ((Get-Service -Name $ServiceNavn).Status -eq "Running") {

                    Write-Host "$ServiceNavn er genstartet og koerer!" -ForegroundColor Green
                }

                else {

                    Write-Host "$ServiceNavn blev genstartet, men koerer ikke!" -ForegroundColor Red
                }
            }

            catch {

                Write-Host "$ServiceNavn kunne ikke genstartes" -ForegroundColor Red
            }
        }

        else {

            do {

                Write-Host "$ServiceNavn er sat til 'Manual'. Vil du starte denne service?" -ForegroundColor Yellow

                $valg = Read-Host "Vaelg [y]/[n] > "
            } 
            
            until ($valg -in @("y", "n"))
            
            if ($valg -eq "y") {
                
                Try {

                    Start-Service -Name $ServiceNavn -ErrorAction Stop

                    Write-Host "$ServiceNavn startes..." -ForegroundColor Yellow

                    if ((Get-Service -Name $ServiceNavn).Status -eq "Running") {

                        Write-Host "$ServiceNavn blev startet og koerer" -ForegroundColor Green
                    }

                    else {

                        Write-Host "$ServiceNavn blev startet, men koerer stadig ikke" -ForegroundColor Red
                    }
                }
                
                catch {

                    Write-Host "$ServiceNavn kunne ikke startes" -ForegroundColor Red
                }
            }
        }
    }
}

Sektion "SERVICE SCREENER STARTER"

$loop = $true

while ($loop) {

    Sektion "MENU"

    Write-Host "1. Tjek kritiske services"
    Write-Host "2. Angiv og tjek service"
    Write-Host "3. Afslut"
    Write-Host ""

    $valg = Read-Host "Vaelg"

    switch ($valg) {

        "1" {

            Sektion "Tjekker kritiske services"
            Service_Liste
        }

        "2" {

            Sektion "Tjek en specifik service"

            $tjek = Read-Host "Indtast service > "

            Tjek_ServiceStatus -ServiceNavn $tjek
        }

        "3" {

            Sektion "SERVICE SCREENER STOPPER"

            Stop-Transcript

            Write-Host "Loggen gemmes her:" -ForegroundColor Cyan

            Write-Host $log

            $loop = $false
        }

        default {

            Write-Host ""
            Write-Host "Ugyldigt valg!"
        }
    }
}