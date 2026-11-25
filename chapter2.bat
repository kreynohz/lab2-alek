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
