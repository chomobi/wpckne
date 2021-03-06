## Введение

После того, как вы написали перевод для EU4 и преобразовали его в кодировку CP1251 или CP1252CYR, создали мод и подключили к игре, вам может понадобиться вводить её с клавиатуры в самой игре, для чего и предназначена данная программа. Она работает со вводом в окно напрямую, поэтому изначально избавлена от проблем с задержками. Также вам не придётся больше устанавливать в систему специальную раскладку клавиатуры и испытывать проблемы с её переключением в игре и вне её.

## Как пользоваться

1. Распакуйте релизный архив `wpckne.7z`.
2. Положите распакованные файлы `wpckne.exe` и `wpckhk64.dll` в один каталог.
3. Запустите на исполнение `wpckne.exe`.
4. Убедитесь в правильности настроек и, при необходимости, измените их.
5. Запустите игру.
6. Проверьте работу ввода.

## Настройки

Crusader Kings II и Europa Universalis IV — влияет на выбор варианта кодировки Lite-русификатора.

CP1251 — кодировка Full и LiteMP русификаторов.

CP1252CYR — кодировка Lite-русификатора.

## Связь с автором

Если у вас возникли проблемы, вопросы или предложения по поводу данной программы то пишите на адрес, указанный в лицензии, или на [Discord-сервер](https://discord.gg/uwvsCFZ).

## Лицензия

Copyright © 2018, 2022 terqüéz

Этот текст доступен на условиях лицензии [CC BY-NC-ND 4.0 Международная](https://creativecommons.org/licenses/by-nc-nd/4.0/). Программный код доступен на условиях GPLv3 или (по вашему выбору) более поздней версии.
<!--
Как это работает
Вы запускаете wpckne.exe, который ждёт повления окна игры. Как только окно появилось, в процесс, связанный с окном, подгружается библиотека с хуком, который который преобразует символы кодировки UTF16, в которой их отправляет Windows в окно игры, в символы CP1252, как их ожидает движок.
-->
