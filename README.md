# Camera Ping Checker

Проверка доступности IP-камер по списку из файла **camera_list.json**.

## Описание

Скрипт `ping_camera.py` позволяет автоматически проверить, какие IP-камеры из списка недоступны (не отвечают на ping). Результат выводится в консоль для каждой недоступной камеры.

- Входные данные: файл **camera_list.json** с описанием камер.
- Для каждой камеры выводится строка, если она НЕ отвечает на ping.
- Поддерживает кириллические и латинские имена камер.

## Формат входных данных

**camera_list.json**  
Массив объектов с ключами:

```json
[
  {"ID": "CAMERA1", "Name": "Entrance", "IP": "192.168.10.1"},
  {"ID": "CAMERA2", "Name": "Exit", "IP": "192.168.10.2"},
]
```

## Использование

1. Поместите `ping_camera.py` и `camera_list.json` в одну папку.
2. Запустите скрипт через командную строку:

   ```bash
   python ping_camera.py
   ```

3. В консоли появятся записи вида:

   ```
   Name: 3-2 | IP: 192.168.6.9 | Status:
   ```

   — только для недоступных камер.

4. В конце выводится сообщение `Finish` и 5 секунд паузы перед завершением работы.

## Зависимости

- Python 3.6+
- Работает под Windows (используется ключ `-n` в ping)

## Примечания

- Для корректной работы убедитесь, что у вас есть права на чтение файла **camera_list.json**.
- Если имя камеры отсутствует, будет выведено "NO NAME".
- Время ожидания ответа от устройства — 5 секунд.

---

# Camera Ping Checker

Check availability of IP cameras from a list in **camera_list.json**.

## Description

`ping_camera.py` script automatically checks which IP cameras from your list are unavailable (do not respond to ping). For each unreachable camera, its info is printed to the console.

- Input: **camera_list.json** describing cameras.
- For each unreachable camera, a line is printed.
- Supports Cyrillic and Latin camera names.

## Input Data Format

**camera_list.json**  
An array of objects with fields:

```json
[
  {"ID": "BASE3_1", "Name": "3-4", "IP": "192.168.6.14"},
  {"ID": "BASE3_2", "Name": "3-2", "IP": "192.168.6.9"},
  ...
]
```

## Usage

1. Put `ping_camera.py` and `camera_list.json` in the same folder.
2. Run the script in your command line:

   ```bash
   python ping_camera.py
   ```

3. The console will show lines like:

   ```
   Name: 3-2 | IP: 192.168.6.9 | Status:
   ```

   — only for unavailable cameras.

4. At the end, you’ll see `Finish` and a 5-second pause before exit.

## Requirements

- Python 3.6+
- Works on Windows (uses the `-n` key in ping)

## Notes

- Make sure you have permission to read **camera_list.json**.
- If the camera name is missing, "NO NAME" will be shown.
- Ping timeout is set to 5 seconds per camera.
