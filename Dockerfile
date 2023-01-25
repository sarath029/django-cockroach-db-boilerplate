FROM python:3.10

LABEL vendor="Django CockroachDB"

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PYTHONDONTWRITEBYTECODE 1

ENV PYTHONUNBUFFERED 1
WORKDIR /code

RUN apt-get update && apt-get install -y gcc
RUN apt-get update ;
RUN pip install pipenv && pip install psycopg2

COPY Pipfile Pipfile.lock ./

RUN pipenv install

COPY /start_backend /start_backend
RUN sed -i 's/\r$//g' /start_backend
RUN chmod +x /start_backend

COPY . ./
EXPOSE 8000