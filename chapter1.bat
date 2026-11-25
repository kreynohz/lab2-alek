@echo off
chcp 65001 > nul
set score_fastapi=0
set score_django=0
set score_flask=0

echo ==========================================
echo   МОДУЛЬ 1: ВЫБОР ФРЕЙМВОРКА ДЛЯ БЭКЕНДА
echo ==========================================
echo.

echo Вопрос 1 из 6: Какая ожидается нагрузка на API?
echo 1. Высокая нагрузка и много асинхронных запросов
echo 2. Средняя нагрузка, стандартный веб-проект
echo 3. Небольшой сервис или прототип
choice /c 123 /n
if errorlevel==3 set /a score_flask+=15
if errorlevel==2 set /a score_django+=10
if errorlevel==1 set /a score_fastapi+=15
echo.

echo Вопрос 2 из 6: Что нужно получить из коробки?
echo 1. ORM, админку, авторизацию, миграции - всё сразу
echo 2. Только API, максимально лёгкое ядро
echo 3. Автоматическую документацию API OpenAPI и Swagger
choice /c 123 /n
if errorlevel==3 set /a score_fastapi+=15
if errorlevel==2 set /a score_flask+=15
if errorlevel==1 set /a score_django+=20
echo.

echo Вопрос 3 из 6: С чем команда уже работала?
echo 1. С Django
echo 2. С Flask или другими микрофреймворками
echo 3. С асинхронным Python и аннотациями типов
choice /c 123 /n
if errorlevel==3 set /a score_fastapi+=15
if errorlevel==2 set /a score_flask+=15
if errorlevel==1 set /a score_django+=15
echo.

echo Вопрос 4 из 6: Какие сроки разработки?
echo 1. Срочно, нужно быстро выпустить MVP
echo 2. Есть время, важен полный контроль над архитектурой
choice /c 12 /n
if errorlevel==2 set /a score_flask+=10
if errorlevel==1 (
    set /a score_fastapi+=10
    set /a score_django+=10
)
echo.

echo Вопрос 5 из 6: Как должна работать валидация входных данных?
echo 1. Автоматически по аннотациям типов
echo 2. Через собственные сериализаторы и формы
choice /c 12 /n
if errorlevel==2 (
    set /a score_django+=10
    set /a score_flask+=5
)
if errorlevel==1 set /a score_fastapi+=10
echo.

echo Вопрос 6 из 6: Что важнее в выборе инструмента?
echo 1. Зрелая экосистема и много готовых библиотек
echo 2. Современный стек и скорость работы
choice /c 12 /n
if errorlevel==2 set /a score_fastapi+=10
if errorlevel==1 (
    set /a score_django+=10
    set /a score_flask+=10
)
echo.

echo ========== Результаты ==========
echo FastAPI: %score_fastapi% баллов
echo Django:  %score_django% баллов
echo Flask:   %score_flask% баллов
echo.

if %score_fastapi% geq %score_django% if %score_fastapi% geq %score_flask% (
    set res_mod1=FastAPI
) else if %score_django% geq %score_flask% (
    set res_mod1=Django
) else (
    set res_mod1=Flask
)

echo Рекомендация: %res_mod1%
echo.
pause
