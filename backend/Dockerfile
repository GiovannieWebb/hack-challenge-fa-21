FROM python:3.8.0

RUN mkdir usr/app
WORKDIR usr/app

COPY . .

RUN pip3 install -r requirements.txt
CMD python3 app.py