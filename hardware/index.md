# Gerenciamento Ativo de Energia do Estado (ASPM)

O Gerenciamento Ativo de Energia do Estado (ASPM - Active State Power Management) é uma tecnologia de gerenciamento de energia usada em sistemas de computadores para reduzir o consumo de energia controlando o estado de energia de vários componentes de hardware, como placas gráficas, adaptadores de rede e controladores de armazenamento. Ele ajuda a reduzir o consumo de energia e melhorar a eficiência energética desses dispositivos.

O ASPM geralmente é ativado por padrão em sistemas de computadores modernos. No entanto, ele pode ser ativado ou desativado manualmente por meio das configurações do BIOS ou firmware UEFI do sistema. Os passos específicos para acessar e modificar essas configurações podem variar dependendo do fabricante e modelo do sistema.

---
## Como usar o ASPM

Se você suspeita que o ASPM está causando problemas em seu sistema, pode tentar desativá-lo temporariamente para ver se o problema desaparece. Para fazer isso, você pode adicionar o parâmetro de kernel `pcie_aspm=off` às opções de inicialização.

1. Edite o arquivo de configuração do GRUB em `/etc/default/grub` com um editor de texto como `nano` ou `vi`.

```
$ sudo nano /etc/default/grub
```

2. Encontre a linha que começa com `GRUB_CMDLINE_LINUX_DEFAULT` e adicione o parâmetro de kernel `pcie_aspm=off` aos parâmetros existentes entre as aspas. Por exemplo:

```
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pcie_aspm=off"
```

3. Salve o arquivo e saia do editor de texto.

4. Atualize a configuração do GRUB executando o seguinte comando:

```
$ sudo update-grub
```

5. Reinicie o sistema para que as alterações tenham efeito.

Após desativar o ASPM, você pode usar o comando `lspci -vv` para verificar se as configurações do ASPM foram desativadas para os seus dispositivos. Se ainda houver problemas, pode ser necessário investigar mais ou procurar a assistência de um técnico qualificado.

---
## Forçar o ASPM

> **Aviso:** Forçar o ASPM pode causar instabilidade do sistema ou diminuição de desempenho se não for feito corretamente. Você só deve forçar o ASPM se tiver um motivo específico para fazê-lo e tiver testado completamente o sistema para garantir que ele esteja estável e funcionando conforme o esperado.

Dito isso, se você tiver um motivo específico para forçar o ASPM e tiver testado completamente o sistema, pode seguir os seguintes passos para forçar o ASPM em um sistema Linux:

Adicione o parâmetro de kernel `pcie_aspm=force` aos parâmetros existentes entre as aspas. Por exemplo:

```
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pcie_aspm=force"
```

Lembre-se de ter cautela ao usar essa opção e tenha certeza de que está ciente dos possíveis riscos envolvidos.