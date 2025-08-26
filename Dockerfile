FROM python:3.11-slim-bullseye

# Установка системных зависимостей
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y libpq-dev build-essential

# Создание рабочей директории
WORKDIR /app

# Копирование файлов зависимостей
COPY requirements.txt .

# Установка Python зависимостей
RUN pip install --no-cache-dir -r requirements.txt

# Копирование исходного кода
COPY src/run.py .
COPY src/app ./app

# Открытие порта
EXPOSE 5000

# Запуск приложения
CMD ["gunicorn", "-b", "0.0.0.0:5000", "run:app"]