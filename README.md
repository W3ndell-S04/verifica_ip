🔍 Descobrindo IPs Disponíveis na Rede com PowerShell
Este repositório contém um script em PowerShell criado para automatizar a tarefa de identificar IPs livres em uma rede local — de forma rápida, prática e sem ferramentas adicionais.

💡 Contexto
Durante uma rotina de suporte, um computador que usava IP fixo foi alterado para DHCP e parou de se comunicar com a rede.
A missão era simples:
🔧 "Descubra um IP disponível na rede para configurar no PC e restaurar a comunicação."

Para resolver isso de forma eficiente, desenvolvi este script.

⚙️ O que o script faz
✅ Varre todos os IPs válidos da rede 192.168.1.0/24
✅ Verifica quais IPs não estão em uso (via ping)
✅ Usa execução paralela com limite de 20 tarefas simultâneas (mais rápido e leve)
✅ Salva os IPs disponíveis em um arquivo ips_livres.txt

🚀 Como usar
Abra o PowerShell no Windows (você não precisa ser administrador)

Copie o conteúdo do script verificar_ips_disponiveis.ps1 deste repositório

Execute o script com o comando:

powershell

`.\verificar_ips_disponiveis.ps1`

Após a execução, o arquivo ips_livres.txt será criado no mesmo diretório contendo todos os IPs livres detectados.

📝 Exemplo de saída
txt
```
192.168.1.13
192.168.1.27
192.168.1.45
```

📂 Arquivo gerado
ips_livres.txt: Lista de IPs válidos que não estão sendo utilizados no momento da varredura.


📎 Compartilhamento
Este projeto surgiu de uma necessidade real no ambiente de TI.
Você pode conferir o post sobre isso no meu LinkedIn.



