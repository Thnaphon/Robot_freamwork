*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${SERVER}         melivecode.com
${BROWSER}        Chrome
${DELAY}          0
${VALID USER}     karn.yong@melivecode.com
${VALID PASSWORD}    melivecode
${LOGIN URL}      https://${SERVER}/login/login.html
${WELCOME URL}    https://${SERVER}/login/index.html
${ERROR URL}      https://${SERVER}/login/login.html

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Login Page Should Be Open

Login Page Should Be Open
    Title Should Be    Me Live Code - Login

Go To Login Page
    Go To    ${LOGIN URL}
    Login Page Should Be Open

Input Username
    [Arguments]    ${username}
    Input Text    username    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    password    ${password}

Submit Credentials
    Click Button    login_button
    Wait Until Page Contains    Profile Page

Submit Credentials Invalid
    Click Button    login_button
   

Welcome Page Should Be Open
    Location Should Be    ${WELCOME URL}
    Title Should Be    Profile Page


Login With Invalid Credentials Should Fail
    [Arguments]    ${username}    ${password}
    Input Username    ${username}
    Input Password    ${password}
    Submit Credentials Invalid
    Login Should Have Failed

Login Should Have Failed
    Title Should Be    Me Live Code - Login
    Location Should Be  ${ERROR URL} 