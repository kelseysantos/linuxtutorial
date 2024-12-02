import paramiko

# Função para executar o comando via SSH usando chave privada
def executar_comando_ssh(ip, usuario, caminho_chave, comando):
    try:
        cliente = paramiko.SSHClient()
        cliente.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        chave_privada = paramiko.RSAKey.from_private_key_file(caminho_chave)
        cliente.connect(ip, username=usuario, pkey=chave_privada)
        stdin, stdout, stderr = cliente.exec_command(comando)
        saida = stdout.read().decode('utf-8')
        erro = stderr.read().decode('utf-8')
        if saida:
            print(f"Saída de {ip}: {saida}")
        if erro:
            print(f"Erro em {ip}: {erro}")
        cliente.close()
    except Exception as e:
        print(f"Erro ao conectar ao IP {ip}: {e}")

# lista_ips = ['192.168.246.17', '192.168.246.18', '192.168.246.19']
lista_ips = 'ips.txt'
# lista_ips = 'prod.txt'

usuario = 'root'
caminho_chave = '/root/.ssh/id_rsa'

# Comando que você quer executar
# comando = 'apt update -y'
comando = "apt clean;apt update -y;apt full-upgrade -y;apt upgrade -y;apt autoremove -y"
# comando = 'timedatectl'
# comando = "df -h --output=source,size,used,pcent | grep '/dev/mapper' | sort -nrk 4 | head -n 4"

# Executa o comando em todos os IPs
with open(lista_ips, 'r') as file:
    # Lê o conteúdo do arquivo
    conteudo = file.readlines()
# for linha in conteudo:
#     # Remove o '\n' do final de cada linha ao exibir
#     print(linha.strip())
for ip in conteudo:
    executar_comando_ssh(ip.strip(), usuario, caminho_chave, comando)
