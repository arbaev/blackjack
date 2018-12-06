# Учебный проект: игра Blackjack

## TODO
1. Написать класс интерфейса: запрос ввода игрока и вывод хода игры

## Done
1. Продумать объектную модель игры и связи между объектами
1. Написать классы карты и колоды
1. Написать класс игрока
1. Написать класс игры

## Объектная модель игры
#### Классы
1. Game
* задаёт игроков, банк, определяет ставку
2. Round
* один рауд игры, принимает игроков и ставку, возвращает победителя
3. Player
* определяет параметры игрока: имя, банк, текущие карты, подсчёт очков
* запрашивает решение игрока
4. Dealer
* подкласс Player, автоматическое принятие решения на основе игровой логики
5. Deck
* перетасовывает карты и сдаёт по одной
4. Card
* определяет параметры карты: название, масть, количество очков, представление

5. Интерфейс
6. Валидация

## Механика и правила игры:

Есть игрок (пользователь) и дилер (управляется программой).
Вначале запрашиваем у пользователя имя, после чего начинается игра.
При начале игры у пользователя и дилера в банке находится по 100 долларов
Пользователю выдаются случайные 2 карты, которые он видит (карты указываем условными обозначениями, например, «К+» - король крестей, «К<3» - король черв, «К^» - король пик, «К<>» - король бубен и т.д. При желании, можете использовать символы юникода для мастей.)
Также 2 случайные карты выдаются «дилеру», против которого играет пользователь. Пользователь не видит карты дилера, вместо них показываются звездочки.
Пользователь видит сумму своих очков. Сумма считается так: от 2 до 10 - по номиналу карты, все «картинки» - по 10, **туз - 1 или 11, в зависимости от того, какое значение будет ближе к 21 и что не ведет к проигрышу (сумме более 21).**
После раздачи, автоматически делается ставка в банк игры в размере 10 долларов от игрока и диллера. (У игрока и дилера вычитается 10 из банка)
После этого ход переходит пользователю. У пользователя есть на выбор 3 варианта:
- __*Пропустить.*__ В этом случае, ход переходит к дилеру (см. ниже)
- __*Добавить карту.*__ (только если у пользователя на руках 2 карты). В этом случае игроку добавляется еще одна случайная карта, сумма очков пересчитывается, ход переходит дилеру. **Может быть добавлена только одна карта.**
- __*Открыть карты.*__ Открываются карты дилера и игрока, игрок видит сумму очков дилера, идет подсчет результатов игры (см. ниже).

Ход дилера (управляется программой, цель - выиграть, то есть набрать сумму очков, максимально близкую к 21). Дилер может:
- __*Пропустить ход* (если очков у дилера 17 или более)__. Ход переходит игроку.
- __*Добавить карту* (если очков менее 17)__. У дилера появляется новая карта (для пользователя закрыта). После этого ход переходит игроку. Может быть добавлена только одна карта.

Игроки вскрывают карты либо по достижению у них по 3 карты (автоматически), либо когда пользователь выберет вариант «Открыть карты». После этого пользователь видит карты дилера и сумму его очков, а также результат игры (кто выиграл и кто проиграл).
Подсчет результатов:

- Выигрывает игрок, у которого сумма очков ближе к 21
- Если у игрока сумма очков больше 21, то он проиграл
- Если сумма очков у игрока и дилера одинаковая, то объявляется ничья и деньги из банка возвращаются игрокам
- Сумма из банка игры переходит к выигравшему

После окончания игры, спрашиваем у пользователя, хочет ли он сыграть еще раз. Если да, то игра начинается заново с раздачи карт, если нет - то завершаем работу.
