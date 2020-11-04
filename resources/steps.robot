*** Settings ***
Library            Selenium2Library
Library            ../lib/MyIp.py
Library            ../lib/CustomLib.py
Library            ../lib/Log.py

*** Variables ***
# preencher somente váriaveis de usuário e senha
${BROWSER}            chrome
${URL}                https://developer.clashroyale.com/
${USERNAME_LOGIN}     <Username>
${PASSWORD_LOGIN}     <password>
${KEY_NAME}           Create Key test
${KEY_DESCRIPTION}    Test
${NAME_OF_CLAN}       resistance
${LOCATION_ID}        57000038
${TAG}                \#9V2Y
${FILENAME}           members.csv
${DEBUG}              DEBUG
${INFO}               INFO
${ERROR}              ERROR
${IP_ADDRESS}
${TOKEN}

*** Keywords ***
# Setup
Navegar para página Inicial
    Open Browser    ${URL}   ${BROWSER}
    Maximize browser window

# Steps
Navegar para página de Login
    Wait Until Page Contains Element  xpath=//*[@id="content"]/div/div[2]/div/header/div/div/div[3]/div/a[2]
    Click Link                        xpath=//*[@id="content"]/div/div[2]/div/header/div/div/div[3]/div/a[2]

Realizar login com usuário e senha valido
    Input Text        id=email            ${USERNAME_LOGIN}
    Input password    id=password         ${PASSWORD_LOGIN}
    Click Button      xpath=//*[@id="content"]/div/div[2]/div/div/div/div/div/div/form/div[4]/button

Navegar até "My Account" e criar chave
    Wait Until Page Contains Element  xpath=//*[@id="content"]/div/div[2]/div/header/div/div/div[3]/div/div/button/span[2]    3m
    Click Element                     xpath=//*[@id="content"]/div/div[2]/div/header/div/div/div[3]/div/div/button/span[2]
    Sleep                             1s
    Click Link                        xpath=//*[@id="content"]/div/div[2]/div/header/div/div/div[3]/div/div/ul/li[1]/a
    Sleep                             1s
    Click Element                     xpath=//*[@id="content"]/div/div[2]/div/div/section[2]/div/div/div[2]/p/a
    sleep                             1s
    Input Text                        id=name               ${KEY_NAME}
    Input Text                        id=description        ${KEY_DESCRIPTION}
    # buscando IP externo
    ${IP_ADDRESS}=                    get my ip
    Input Text                        id=range-0            ${IP_ADDRESS}
    Click Element                     xpath=//*[@id="content"]/div/div[2]/div/div/section/div/div/div[2]/form/div[5]/button

Capturar token gerado
    Wait Until Page Contains Element  xpath=//*[@id="content"]/div/div[2]/div/div/section[2]/div/div/div[2]/ul/li/a
    Click Element                     xpath=//*[@id="content"]/div/div[2]/div/div/section[2]/div/div/div[2]/ul/li/a
    ${TOKEN}=                         Get Text    xpath=//*[@id="content"]/div/div[2]/div/div/section/div/div/div[2]/form/div[1]/div/samp
    Set Global Variable               ${TOKEN}    ${TOKEN}

Buscar clan por nome "The resistance" com Tag que inicia com "##9V2Y"
    ${TAG}=                           Search Clan         ${TOKEN}    ${NAME_OF_CLAN}    ${LOCATION_ID}    ${TAG}
    Set Global Variable               ${TAG}              ${TAG}

Buscar por membros do clan
    ${MEMBERS}=                       Search Members      ${TOKEN}      ${TAG}
    Set Global Variable               ${MEMBERS}          ${MEMBERS}

Gerar arquivo com csv
    ${RESULT}=                        Write CSV           ${FILENAME}   ${MEMBERS}

Test Generico Teardown
    Run Keyword If Test Failed    Teste falhou
    Run Keyword If Test Passed    Teste passou

Teste falhou
    ${RESULT}=              Logging Information     ${TEST MESSAGE}     ${ERROR}

Teste passou
    ${RESULT}=              Logging Information     ${TEST MESSAGE}     ${INFO}
