@echo off
chcp 65001 > nul

:weights
echo ==========================================
echo   МОДУЛЬ 3: СРАВНИТЕЛЬНЫЙ АНАЛИЗ WSM
echo ==========================================
echo.
echo Назначьте веса критериям, сумма должна быть равна 100:
set /p w1="Вес критерия 1 - Производительность: "
set /p w2="Вес критерия 2 - Скорость разработки: "
set /p w3="Вес критерия 3 - Простота освоения: "
set /a total_weight=w1+w2+w3

if %total_weight% neq 100 (
    echo Ошибка: сумма весов равна %total_weight%, а должна быть 100! Попробуйте снова.
    echo.
    goto weights
)

echo.
echo Оцените альтернативы по шкале от 1 до 5:
echo --- FastAPI ---
set /p fa_1="FastAPI - Производительность [1-5]: "
set /p fa_2="FastAPI - Скорость разработки [1-5]: "
set /p fa_3="FastAPI - Простота освоения [1-5]: "

echo --- Django ---
set /p dj_1="Django - Производительность [1-5]: "
set /p dj_2="Django - Скорость разработки [1-5]: "
set /p dj_3="Django - Простота освоения [1-5]: "

echo --- Flask ---
set /p fl_1="Flask - Производительность [1-5]: "
set /p fl_2="Flask - Скорость разработки [1-5]: "
set /p fl_3="Flask - Простота освоения [1-5]: "

set /a score_fa=fa_1*w1+fa_2*w2+fa_3*w3
set /a score_dj=dj_1*w1+dj_2*w2+dj_3*w3
set /a score_fl=fl_1*w1+fl_2*w2+fl_3*w3

echo.
echo ============ Матрица решений ============
echo Критерий              ^| Вес ^| FastAPI ^| Django ^| Flask
echo Производительность    ^| %w1%  ^| %fa_1%       ^| %dj_1%      ^| %fl_1%
echo Скорость разработки   ^| %w2%  ^| %fa_2%       ^| %dj_2%      ^| %fl_2%
echo Простота освоения     ^| %w3%  ^| %fa_3%       ^| %dj_3%      ^| %fl_3%
echo ИТОГО S               ^|     ^| %score_fa%     ^| %score_dj%    ^| %score_fl%
echo.

set max_score=%score_fa%
if %score_dj% gtr %max_score% set max_score=%score_dj%
if %score_fl% gtr %max_score% set max_score=%score_fl%

set count_max=0
if %score_fa%==%max_score% set /a count_max+=1
if %score_dj%==%max_score% set /a count_max+=1
if %score_fl%==%max_score% set /a count_max+=1

if %count_max% gtr 1 (
    set res_mod3=Ничья, максимальный балл %max_score%
) else if %score_fa%==%max_score% (
    set res_mod3=FastAPI, балл %score_fa%
) else if %score_dj%==%max_score% (
    set res_mod3=Django, балл %score_dj%
) else (
    set res_mod3=Flask, балл %score_fl%
)

echo Победитель: %res_mod3%
echo.
pause

