# Como instalar o Chatwoot

Para funcionar 100% o Chatwoot precisa de várias configurações desde banco de dados até chaves da Open Ai e outras opcionais.


##### Tabela de conteúdos
1. [Pré-requisitos](#pré-requisitos)  
2. [Instalação](#instalação) 
   - [Migração do banco de dados do Chatwoot](#passo-1-deploy-da-stack-com-o-comando-de-migração.)
   - [Expor o Chatwoot na porta 3000](#passo-2-expor-o-frontend-na-porta-3000-do-container.)
3. [Personalização](#personalização)
<a name="headers"/>

## Headers


## Pré-requisitos
1. Essenciais
   - Encryption key 256 gerada usando o [Random Key Generator](https://acte.ltd/utils/randomkeygen)
   - Postgres
      - Database com o nome de chatwoot criada
   - Redis
2. Opcionais
   - SMTP para envio de emails (Gmail para testes, Amazon SES para produção)
   - Open AI secret key para copiloto
   - Google Auth para botão na tela de login, precisa de configurar a [tela de consentimento](https://console.cloud.google.com/apis/credentials/consent) e [credenciais](https://console.cloud.google.com/apis/credentials)
   - Logotipos usando os mesmos tamanhos e nomes da [pasta public](https://github.com/matheusmaiberg/Stacks-Incriveis/tree/main/chatwoot/public).

## Instalação

Copie o conteudo da stack do [Chatwoot](https://github.com/matheusmaiberg/Stacks-Incriveis/blob/main/chatwoot/chatwoot.yml) para seu Portainer.

Arrume as credenciais e configurações de acordo com o arquivo [.env](https://github.com/matheusmaiberg/Stacks-Incriveis/blob/main/chatwoot/chatwoot.yml)

### Deploy em 2 passos

O Chatwoot precisa ser executado o deploy em dois passos, primeiro migramos as tabelas do banco de dados Postgres, depois vamos expor as aplicações para o mundo

#### Passo 1, deploy da stack com o comando de migração.

```yaml
[...]
services:
  chatwoot:
    command: bundle exec rails db:chatwoot_prepare 
    # command: bundle exec rails s -p 3000 -b 0.0.0.0 # O comando de inicialização agora está comentado
[...]

```

Aguarde os logs de deploy terminarem a migração, o processo demora de 2 a 5 minutos dependendo da sua VPS e pode ser acompanhado nos logs do container.

#### Passo 2, expor o frontend na porta 3000 do container.

Apos o processo completo de constução do banco de dados vamos alterar a stack do Chatwoot simplesmente comentando o comando de migração e descomentando o comando de inicialização do frontend:

```yaml
[...]
services:
  chatwoot:
    # command: bundle exec rails db:chatwoot_prepare # O comando de migração agora está comentado
    command: bundle exec rails s -p 3000 -b 0.0.0.0
[...]

```

## SMTP

## Open AI

## Google Auth

## Personalização

A stack já está pré configurada para receber personalizações de logotipo e marcas com a `INSTALLATION_NAME` sendo a variável usada para mudar o nome da sua instalação do chatwoot, e um segundo mapeamento `/root/Stacks-Incriveis/chatwoot/public:/app/public` para mapear a pasta public que tem arquivos de logotipo para dentro do seu container docker.

> Aonde `/root/Stacks-Incriveis/chatwoot/public:/app/public` se traduz em um volume mapeado dividido em duas partes:
> 
> `/root/Stacks-Incriveis/chatwoot/public` é a pasta que tem os arquivos na sua VPS.
> `:/app/public` é o mapeamento interior do container em que será enviado seus arquivos para uso do docker quando estiver ativo o container.

> [!WARNING]
> Certifique que quando descomentar esse volume sua pasta public esteja criada dentro da sua VPS, se o caminho estiver vazio ou incorreto sua imagem não ira iniciar até que o caminho esteja com mapeado e com os arquivos corretos.

### Exemplo:

```yaml
version: '3.8'
x-variaveis:
  &variaveis
    INSTALLATION_NAME: "Sua Empresa"
    [...] # Outras váriaveis
services:
  chatwoot:
  [...] # Outras configurações da imagem
    volumes:
      - chatwoot_data:/app/storage
      # Pasta com os arquivos do frontend (favicon, logo e outras)
       - /root/Stacks-Incriveis/chatwoot/public:/app/public # Com a pasta descomentada você pode apontar para dentro do seu servidor o caminho da pasta public com sua logotipo
  [...] # Outras configurações da imagem
```

Please make sure to update tests as appropriate.

## License

[MIT](https://choosealicense.com/licenses/mit/)

