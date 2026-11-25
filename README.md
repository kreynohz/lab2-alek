# Лабораторная работа №2. Моделирование процессов принятия решений в разработке ПО

**Выполнил:** Милана Алек  
**Группа:** 3525п1ин3 
**Вариант:** 6 — Выбор фреймворка для бэкенда (`FastAPI`, `Django`, `Flask`)  
**Ссылка на репозиторий:** https://github.com/kreynohz/lab2-alek

---

## 1. Описание и листинги модулей

### Модуль 1 (`chapter1.bat`) — Выбор технологии
Интерактивный опросник из 6 вопросов о характеристиках проекта (ожидаемая нагрузка, необходимость готовых компонентов из коробки, опыт команды, сроки разработки, способ валидации данных и приоритеты при выборе стека). По итогам ответов начисляются баллы кандидатам (`FastAPI`, `Django`, `Flask`) и формируется рекомендация.

```bat
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
if %errorlevel%==3 set /a score_flask+=15
if %errorlevel%==2 set /a score_django+=10
if %errorlevel%==1 set /a score_fastapi+=15
echo.

echo Вопрос 2 из 6: Что нужно получить из коробки?
echo 1. ORM, админку, авторизацию, миграции - всё сразу
echo 2. Только API, максимально лёгкое ядро
echo 3. Автоматическую документацию API OpenAPI и Swagger
choice /c 123 /n
if %errorlevel%==3 set /a score_fastapi+=15
if %errorlevel%==2 set /a score_flask+=15
if %errorlevel%==1 set /a score_django+=20
echo.

echo Вопрос 3 из 6: С чем команда уже работала?
echo 1. С Django
echo 2. С Flask или другими микрофреймворками
echo 3. С асинхронным Python и аннотациями типов
choice /c 123 /n
if %errorlevel%==3 set /a score_fastapi+=15
if %errorlevel%==2 set /a score_flask+=15
if %errorlevel%==1 set /a score_django+=15
echo.

echo Вопрос 4 из 6: Какие сроки разработки?
echo 1. Срочно, нужно быстро выпустить MVP
echo 2. Есть время, важен полный контроль над архитектурой
choice /c 12 /n
if %errorlevel%==2 set /a score_flask+=10
if %errorlevel%==1 (
    set /a score_fastapi+=10
    set /a score_django+=10
)
echo.

echo Вопрос 5 из 6: Как должна работать валидация входных данных?
echo 1. Автоматически по аннотациям типов
echo 2. Через собственные сериализаторы и формы
choice /c 12 /n
if %errorlevel%==2 (
    set /a score_django+=10
    set /a score_flask+=5
)
if %errorlevel%==1 set /a score_fastapi+=10
echo.

echo Вопрос 6 из 6: Что важнее в выборе инструмента?
echo 1. Зрелая экосистема и много готовых библиотек
echo 2. Современный стек и скорость работы
choice /c 12 /n
if %errorlevel%==2 set /a score_fastapi+=10
if %errorlevel%==1 (
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
```
*Комментарии к коду:* команда `choice` ограничивает ввод пользователя допустимыми цифрами, `set /a` выполняет арифметическое начисление баллов, а условные операторы `if` сравнивают итоговые счётчики и сохраняют имя лидера в переменную `res_mod1`.

---

### Модуль 2 (`chapter2.bat`) — Инспекция кода
Модуль последовательно демонстрирует 5 фрагментов кода на Python для веб-бэкенда и предлагает классифицировать скрытый в каждом фрагменте дефект (неинициализированная переменная, мёртвое присваивание, утечка ресурса, магическое число, отсутствие обработки ошибок). За верный ответ начисляются баллы, за ошибку — снимаются.

```bat
@echo off
chcp 65001 > nul
set correct=0
set score=0
set total=5

echo ==========================================
echo   МОДУЛЬ 2: ИНСПЕКЦИЯ КОДА (БЭКЕНД)
echo ==========================================
echo.

echo Фрагмент 1 из 5 - получение профиля пользователя:
echo 10: @app.get("/users/{user_id}")
echo 11: def get_user(user_id: int):
echo 12:     user = db.query(User).filter(User.id == user_id).first()
echo 13:     return {"name": user.name}
echo.
echo Какой дефект здесь скрыт?
echo 1. Неинициализированная переменная
echo 2. Мёртвое присваивание
echo 3. Утечка ресурса
echo 4. Магическое число
echo 5. Отсутствие обработки ошибок
choice /c 12345 /n
if %errorlevel%==5 (
    echo Верно! Нет проверки, если пользователь не найден и user равен None.
    set /a correct+=1
    set /a score+=10
) else (
    echo Неверно. Правильный ответ: 5. Не обрабатывается случай, когда user равен None.
    set /a score-=5
)
echo.

echo Фрагмент 2 из 5 - чтение конфигурации API:
echo 20: def load_config():
echo 21:     f = open("config.json", "r")
echo 22:     data = json.load(f)
echo 23:     return data
echo.
echo Какой дефект здесь скрыт?
echo 1. Неинициализированная переменная
echo 2. Мёртвое присваивание
echo 3. Утечка ресурса
echo 4. Магическое число
echo 5. Отсутствие обработки ошибок
choice /c 12345 /n
if %errorlevel%==3 (
    echo Верно! Файл открыт без with и не закрывается после чтения.
    set /a correct+=1
    set /a score+=10
) else (
    echo Неверно. Правильный ответ: 3. Файл config.json не закрывается.
    set /a score-=5
)
echo.

echo Фрагмент 3 из 5 - расчёт скидки в заказе:
echo 30: def get_final_price(price: float, is_vip: bool):
echo 31:     if is_vip:
echo 32:         discount = 0.15
echo 33:     return price * (1 - discount)
echo.
echo Какой дефект здесь скрыт?
echo 1. Неинициализированная переменная
echo 2. Мёртвое присваивание
echo 3. Утечка ресурса
echo 4. Магическое число
echo 5. Отсутствие обработки ошибок
choice /c 12345 /n
if %errorlevel%==1 (
    echo Верно! Если is_vip == False, переменная discount не определена.
    set /a correct+=1
    set /a score+=10
) else (
    echo Неверно. Правильный ответ: 1. Переменная discount не инициализирована для обычных клиентов.
    set /a score-=5
)
echo.

echo Фрагмент 4 из 5 - пагинация списка товаров:
echo 40: @app.get("/items")
echo 41: def list_items(page: int = 1):
echo 42:     offset = (page - 1) * 50
echo 43:     return db.query(Item).offset(offset).limit(50).all()
echo.
echo Какой дефект здесь скрыт?
echo 1. Неинициализированная переменная
echo 2. Мёртвое присваивание
echo 3. Утечка ресурса
echo 4. Магическое число
echo 5. Отсутствие обработки ошибок
choice /c 12345 /n
if %errorlevel%==4 (
    echo Верно! Размер страницы 50 повторяется в коде. Нужна константа PAGE_SIZE.
    set /a correct+=1
    set /a score+=10
) else (
    echo Неверно. Правильный ответ: 4. Число 50 нужно вынести в константу PAGE_SIZE.
    set /a score-=5
)
echo.

echo Фрагмент 5 из 5 - выдача токена:
echo 50: def create_token(user):
echo 51:     token = None
echo 52:     token = jwt.encode({"id": user.id}, SECRET)
echo 53:     return token
echo.
echo Какой дефект здесь скрыт?
echo 1. Неинициализированная переменная
echo 2. Мёртвое присваивание
echo 3. Утечка ресурса
echo 4. Магическое число
echo 5. Отсутствие обработки ошибок
choice /c 12345 /n
if %errorlevel%==2 (
    echo Верно! Значение None в token сразу перезаписывается и нигде не используется.
    set /a correct+=1
    set /a score+=10
) else (
    echo Неверно. Правильный ответ: 2. Значение None в token сразу перезаписывается и нигде не используется.
    set /a score-=5
)
echo.

set /a percentage=correct*100/total
if %percentage% geq 80 (
    set res_mod2=Senior Reviewer
) else if %percentage% geq 50 (
    set res_mod2=Middle Reviewer
) else (
    set res_mod2=Junior Reviewer
)

echo ========== Итоговый отчёт ==========
echo Просмотрено фрагментов: %total%
echo Правильных ответов: %correct% из %total%
echo Точность: %percentage%%%
echo Набрано очков: %score%
echo Уровень: %res_mod2%
echo.
pause
```
*Комментарии к коду:* проверка `%errorlevel%` определяет правильность ответа пользователя; в конце вычисляется процент точности (`correct*100/total`) и определяется уровень ревьюера (`Junior`, `Middle` или `Senior Reviewer`) в переменную `res_mod2`.

---

### Модуль 3 (`chapter3.bat`) — Сравнительный анализ альтернатив (WSM)
Реализует метод взвешенной суммы (Weighted Sum Model). Пользователь задаёт веса критериям («Производительность», «Скорость разработки», «Простота освоения») с проверкой равенства суммы 100, затем выставляет оценки от 1 до 5 каждому фреймворку. Программа формирует матрицу решений и объявляет победителя.

```bat
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
```
*Комментарии к коду:* метка `:weights` обеспечивает повторный ввод весов при ошибке суммы; взвешенные баллы рассчитываются по формуле $S = \sum(W 	imes X)$, а логика подсчёта `count_max` корректно обрабатывает как единоличного победителя, так и ничью.

---

### Главный модуль (`lab_system.bat`) — Интеграция системы
Обеспечивает главное текстовое меню с возможностью запуска любого модуля отдельно или последовательного прохождения всей цепочки с автоматической генерацией файла `report.txt`.

```bat
@echo off
chcp 65001 > nul

:menu
cls
echo ====================================================
echo   СИСТЕМА МОДЕЛИРОВАНИЯ ПРОЦЕССОВ РАЗРАБОТКИ ПО
echo   Вариант 6: выбор фреймворка для бэкенда
echo ====================================================
echo.
echo 1. Модуль выбора технологий
echo 2. Модуль инспекции кода
echo 3. Модуль сравнительного анализа
echo 4. Запустить все модули последовательно
echo 5. Выход
echo.
set /p choice="Ваш выбор: "

if "%choice%"=="1" call chapter1.bat
if "%choice%"=="2" call chapter2.bat
if "%choice%"=="3" call chapter3.bat
if "%choice%"=="4" goto run_all
if "%choice%"=="5" exit
goto menu

:run_all
call chapter1.bat
call chapter2.bat
call chapter3.bat
cls
echo ==========================================
echo   ИТОГОВЫЙ ОТЧЁТ СИСТЕМЫ
echo   Вариант 6: выбор фреймворка для бэкенда
echo   Дата: %date% %time%
echo ==========================================
echo Модуль 1. Рекомендация по технологии: %res_mod1%
echo Модуль 2. Уровень ревьюера: %res_mod2%
echo Модуль 3. Победитель сравнительного анализа: %res_mod3%
echo ==========================================
echo.
(
    echo ==========================================
    echo   ИТОГОВЫЙ ОТЧЁТ СИСТЕМЫ
    echo   Вариант 6: выбор фреймворка для бэкенда
    echo   Дата: %date% %time%
    echo ==========================================
    echo Модуль 1. Рекомендация по технологии: %res_mod1%
    echo Модуль 2. Уровень ревьюера: %res_mod2%
    echo Модуль 3. Победитель сравнительного анализа: %res_mod3%
    echo ==========================================
) > report.txt
echo Отчёт сохранён в файл report.txt
pause
goto menu
```
*Комментарии к коду:* команда `call` вызывает дочерние `.bat`-скрипты без закрытия основного процесса, сохраняя переменные `res_mod1`, `res_mod2` и `res_mod3` в общей области видимости для последующей записи в `report.txt`.

---

## 2. Скриншоты работы системы

### Модуль 1 (`chapter1.bat`)
<img width="967" height="520" alt="Снимок" src="https://github.com/user-attachments/assets/a251ce51-172c-4786-b4de-d35553c14e39" />


### Модуль 2 (`chapter2.bat`)
<img width="828" height="499" alt="1" src="https://github.com/user-attachments/assets/7cc45432-ec72-4281-98d9-af3cd833e856" />


### Модуль 3 (`chapter3.bat`)
<img width="702" height="520" alt="2" src="https://github.com/user-attachments/assets/cc4a4b6c-7602-4270-9775-636df807b5f7" />


### Главное меню (`lab_system.bat`)
<img width="845" height="378" alt="3" src="https://github.com/user-attachments/assets/2bc08085-66da-4bfe-ab56-b5f9ed25fcc6" />


### Последовательное прохождение всех модулей (пункт 4) и итоговый отчёт
<img width="922" height="467" alt="ф" src="https://github.com/user-attachments/assets/e21bf158-591c-4bfe-8673-5d544349ecb7" />


---

## 3. Результаты работы интегрированной системы

1. **Диалоги и вопросы:**
   * В первом модуле задавались 6 вопросов о стеке и требованиях к проекту (необходимость ORM/админ-панели, опыт команды с Django/Flask/асинхронным Python, срочность MVP, механизм валидации данных и приоритеты разработки).
   * Во втором модуле анализировались 5 фрагментов кода Python для API-сервисов (включая поиск магических чисел, утечек ресурсов, неинициализированных переменных и мёртвого присваивания в функции генерации JWT-токена `create_token`).
   * В третьем модуле задавались весовые коэффициенты критериев (`50` — производительность, `25` — скорость разработки, `25` — простота освоения) и балльные оценки по шкале 1–5.
2. **Сформированные рекомендации:**
   * По итогам опроса в первом модуле рекомендован фреймворк **FastAPI** (60 баллов против 35 у Flask и 30 у Django).
   * Во втором модуле по результатам инспекции присвоен уровень **Junior Reviewer** (точность 20%, 1 правильный ответ из 5).
   * В третьем модуле построена матрица решений и рассчитаны итоговые взвешенные баллы для каждого фреймворка.
3. **Итоговый отчёт системы:**
   После выбора пункта `4` главного меню система последовательно выполнила все три модуля, сформировала сводный отчёт с указанием варианта, текущей даты и времени, вывела его в консоль и сохранила в текстовый файл `report.txt`.
4. **Впечатления от работы:**
   Реализация модульной системы в виде командных файлов Windows наглядно продемонстрировала принципы формализации инженерных решений: перевод качественных требований в балльные оценки, стандартизацию код-ревью и табличное сравнение альтернатив методом взвешенной суммы.

---

## 4. Инструкция по запуску для другого пользователя

1. Скачайте репозиторий с GitHub (**Code** → **Download ZIP**) и распакуйте архив в любую папку на компьютере под управлением Windows.
2. Убедитесь, что все файлы (`lab_system.bat`, `chapter1.bat`, `chapter2.bat`, `chapter3.bat`) находятся в одной директории.
3. Запустите файл **`lab_system.bat`** двойным кликом левой кнопки мыши.
4. В открывшемся меню введите цифру нужного пункта (`1`–`3` для запуска отдельного модуля или `4` для прохождения всей системы) и нажмите `Enter`.
5. После завершения режима `4` в корневой папке автоматически создастся файл **`report.txt`** с итоговым отчётом.
