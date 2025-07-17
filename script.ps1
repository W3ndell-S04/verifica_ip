# Configurações
$rede = "192.168.1."
$caminhoArquivo = "ips_livres.txt"
$maxJobs = 20

# Limpa arquivo anterior
if (Test-Path $caminhoArquivo) {
    Remove-Item $caminhoArquivo
}

Write-Host "Iniciando varredura com até $maxJobs jobs simultâneos..." -ForegroundColor Cyan

# Lista de IPs
$ips = 1..254 | ForEach-Object { "$rede$_" }

# Função para aguardar e coletar jobs finalizados
function Gerenciar-Jobs {
    param($jobs)
    $novosDisponiveis = @()
    foreach ($job in $jobs) {
        if ($job.State -eq 'Completed') {
            $resultado = Receive-Job $job
            if ($resultado) {
                Write-Host $resultado
                $resultado | Out-File -FilePath $caminhoArquivo -Append
            }
            Remove-Job $job
        }
        else {
            $novosDisponiveis += $job
        }
    }
    return $novosDisponiveis
}

# Lista de jobs ativos
$jobs = @()

foreach ($ip in $ips) {
    # Aguarda vaga se estiver no limite
    while ($jobs.Count -ge $maxJobs) {
        Start-Sleep -Milliseconds 300
        $jobs = Gerenciar-Jobs $jobs
    }

    # Inicia novo job
    $jobs += Start-Job -ScriptBlock {
        param($ip)
        if (-not (Test-Connection -ComputerName $ip -Count 1 -Quiet -ErrorAction SilentlyContinue)) {
            return $ip
        }
    } -ArgumentList $ip
}

# Aguarda todos os jobs finais
Write-Host "Aguardando conclusão dos últimos testes..." -ForegroundColor Yellow
while ($jobs.Count -gt 0) {
    Start-Sleep -Milliseconds 300
    $jobs = Gerenciar-Jobs $jobs
}

Write-Host "`nVerificação concluída. IPs livres salvos em $caminhoArquivo" -ForegroundColor Green
