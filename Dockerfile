FROM drewantech/flask:1.0.0
MAINTAINER Benton Drew <benton.s.drew@drewantech.com>
USER root
RUN apk add --no-cache ca-certificates wget gcc python3-dev musl-dev && \
  update-ca-certificates && \
  wget https://pypi.python.org/packages/44/88/a86ba3fddb1fd7fc2c271355fc11e5f50634e30a0859ccc613fe62973a98/SQLAlchemy-1.1.2.tar.gz && \
  tar xvzf SQLAlchemy-1.1.2.tar.gz && \
  cd SQLAlchemy-1.1.2/ && \
  python3 setup.py install && \
  cd - && \
  rm -r SQLAlchemy-1.1.2/ && \
  rm SQLAlchemy-1.1.2.tar.gz && \
  apk del --no-cache ca-certificates wget gcc python3-dev musl-dev
ADD service/test_sqlalchemy.py .
ENV FLASK_APP test_sqlalchemy.py
USER python_user
ENTRYPOINT ["python3", "-m", "flask", "run"]
CMD ["--host=127.0.0.2", "--port=5001"]
