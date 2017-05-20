FROM drewantech/requests:1.1.0
MAINTAINER Benton Drew <benton.s.drew@drewantech.com>
USER root
RUN rm test_requests.py && \
  apk add --no-cache ca-certificates wget gcc python3-dev musl-dev && \
  update-ca-certificates && \
  wget https://pypi.python.org/packages/a7/8c/cc24b9794ffa87506aedf528ba3a236e11cc537f81a1e3b52193e5e948cd/SQLAlchemy-1.1.10.tar.gz && \
  tar xvzf SQLAlchemy-1.1.10.tar.gz && \
  cd SQLAlchemy-1.1.10/ && \
  python3 setup.py install && \
  cd - && \
  rm -r SQLAlchemy-1.1.10/ && \
  rm SQLAlchemy-1.1.10.tar.gz && \
  apk del --no-cache ca-certificates wget gcc python3-dev musl-dev
ADD service/test_sqlalchemy.py .
ENV FLASK_APP test_sqlalchemy.py
USER python_user
ENTRYPOINT ["python3", "-m", "flask", "run"]
CMD ["--host=127.0.0.2", "--port=5001"]
