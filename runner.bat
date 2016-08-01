@ECHO OFF
::=============================================
SET GITHUB_ACCOUNT=asm94241
SET WS_DIR=Workspace
SET REPO_NAME=Title_Validation_E2E
SET APP_VERSION=1.1
IF "%JAVA_HOME%" == "" GOTO EXIT_JAVA
ECHO Java installed
::IF not exist "%m2%" == GOTO EXIT_MVN
CALL mvn -version > nul 2>&1
IF NOT %ERRORLEVEL% == 0 GOTO EXIT_MVN
ECHO Maven installed
CALL git --version > nul 2>&1
IF NOT %ERRORLEVEL% == 0 GOTO EXIT_GIT
ECHO Git installed

GOTO NEXT
:NEXT
IF NOT EXIST C:\%WS_DIR% md C:\%WS_DIR%
IF EXIST C:\%WS_DIR%\%REPO_NAME% RMDIR /S /Q C:\%WS_DIR%\%REPO_NAME%
CD C:\%WS_DIR%

git clone https://github.com/%GITHUB_ACCOUNT%/%REPO_NAME%

CD %REPO_NAME%

ping -n 1 -w 2000 192.168.254.254 >nul

CALL mvn clean site test -Dtest=AllTests -Dbuild.version="1.1"
ECHO.

GOTO END
:EXIT_JAVA
:ECHO No Java installed
GOTO END
:EXIT_MVN
ECHO No Maven installed
GOTO END
:EXIT_GIT
ECHO No Git installed
GOTO END

GOTO END
:END
CD\