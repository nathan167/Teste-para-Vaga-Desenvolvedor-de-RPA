*** Settings ***
DOCUMENTATION      Teste para Vaga Desenvolvedor de RPA
Resource           ../resources/steps.robot

Suite Setup        Navegar para página Inicial
Suite Teardown     Close All Browsers

*** Test Cases ***
Login
    Navegar para página de Login
    Realizar login com usuário e senha valido
    [Teardown]   Test Generico Teardown

Criar chave e pegar token
    Navegar até "My Account" e criar chave
    Capturar token gerado
    [Teardown]   Test Generico Teardown


API Clash Royale
    Buscar clan por nome "The resistance" com Tag que inicia com "##9V2Y"
    Buscar por membros do clan
    [Teardown]   Test Generico Teardown


Arquivo CSV
    Gerar arquivo com csv
    [Teardown]   Test Generico Teardown
