# Stacks Incriveis
## Stacks prontas pra você implantar na sua VPS com poucos cliques. Chega de ficar procurando no google por arquivos do docker compose para implantar no seu servidor.

Faça o deploy de mais de 5+ open-source apps usando os templates do Portainer ou com um unico comando. E para quem quer segurança com suporte a secrets do docker.

Aplicativos configurados e personalizados ao máximo para implantação em pouquissimos passos.

- [x] Compatibilidade com Traefik
- [x] Compatibilidade com Portainer
- [-] Compatibilidade com Secrets (desenvolvendo)
- [x] Sem necessidade de gerenciar .envs, mas com opção ainda disponivel para quem precisar
- [x] Compatibilidade com (GlusterFS, Ceph, NFS) usando `VOLUME_PATH=/volume/final/`
- [x] Já prontas para instalacão via comando DOMAIN=subdominio.seudominio.com e com diponibilidade do arquivo .env.

### Contribua também
- **Aberto para contribuição** - Qualquer pessoa pode mandar os requests e consertar erros e fornecer atualizações para as versões das aplicações.
- **Implantação simples** - Stacks prontas, com documentação e detalhes sobre cada váriavel em português.
- **Compatibilidade com Swarm e Portainer** - Templates prontos para produção com tudo semi configurado para deploy em servidores pronto para uso.

## Primeiros passos
### Documentação para noobs e intermediários em docker compose.
São usadas variáveis para que você economize tempo ao setar varios aplicativos e não precise digitar seu email ou senha todas as vezes que for fazer o deploy de uma stack.

<details><summary>Veja aqui as variáveis padrão do one click stacks.</summary>
    
- **DOMAIN** - Seu dominio padrão. Ex: seudominio.com.br
- **ACME_EMAIL** - Email usado para aquisição dos certificados Let's Encrypt. SUPER IMPORTANTE
- **SMTP_SENDER** - Email que irá aparecer quando se envia um email novo pelo servidor. Ex: nao-responda@gmail.com
- **SMTP_SERVER** - Endereço do servidor SMTP que irá enviar os emails. Ex: gmail.smtp.com ou mail.seudominio.com
- **SMTP_USER** - Usuário que ira logar no servidor SMTP, normalmente é seu email principal. Ex: seuemail@gmail.com
- **SMTP_PASSWORD** - Senha do seu email ou senha de aplicativo. [Saiba mais sobre senhas de aplicativo](https://atendimento.tecnospeed.com.br/hc/pt-br/articles/4418115119127-Como-criar-senha-de-aplicativo-para-email)
- **NUMBER** - Uma aplicação pode ter varias instancias rodando, -1 -2 -3 -4, se não alterada o padrão será -1. Ex: Portainer-1
- **VERSION** - A versão da aplicação a ser usada no container, se não alterada será usada a ultima versão estável do aplicativo.
- **TRUSTED_IPS** - IP dos servidores que vão se conectar a suas aplicações, se não alterado o padrão sera somente o localhost.
    
</details>

Recomendado somente o uso de váriaveis em senhas para testes ou desenvolvimento, estou adicionando suporte a secrets por padrão para que você tenha mais segurança no deploy, como uso com clientes essas stacks, achei necessário adicionar o suporte a elas.

Variáveis também serão disponivilzadas em arquivos .env para maior controle para quem quiser implantar pelo docker stack compose ou via interface web do portainer.

## Preparando tudo
No ambiente de deploy, ou seja, fora dos testes recomendo fortemente o uso de secrets, que normalmente .

### 1. Deploy Docker
```bash
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```
```bash
 sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
```
```bash
docker swarm init
docker network create --driver=overlay traefik-public
docker stack deploy -c traefik/traefik.yml traefik
```
[Documentação Docker](https://docs.docker.com/engine/install/ubuntu/)

### 2. Deploy Portainer e traefik
```bash
ACME_EMAIL=seuemail@gmail.com DOMAIN=portainer.subdominio.com.br docker stack deploy -c portainer/portainer.yml portainer
docker stack deploy -c traefik/traefik.yml traefik
```

### 3. Cheque se as portais HTTP and HTTPS estão expostas pelo Traefik
```bash
curl https://ipv4.am.i.mullvad.net/port/80
curl https://ipv4.am.i.mullvad.net/port/443
```

### 4. Acesse o portainer
Acesso o endereço do seu VPS com o dominio dele pela porta 9000 http://00.00.00.00:9000 ou pelo subdominio portainer.seudominio.com.br

### 5. Faça o deploy das One Click Stacks
```bash
DOMAIN=<subdominio.meudominio.com.br> docker stack deploy -c <stack.yml> <nome>
```

### Exemplo
```bash
DOMAIN=n8n.seudominio.com.br docker stack deploy -c stacks/n8n.yml n8n
```

## Copiando as stacks dretamente pelo portainer
Na stack do container já tem uma configuração que as stacks são vinculadas com o arquivo templates.json da one click stacks.

Você pode acessar as stacks de dentro do portainer, facilitando ainda mais o deploy e também garante que todas stacks estejam sempre atualizadas.
![](https://user-images.githubusercontent.com/119268809/209490086-f20a83fc-a7bb-4684-a6fa-d712bc17b48e.png)
