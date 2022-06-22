FROM python:3.8

# make Apt non-interactive
RUN echo 'APT::Get::Assume-Yes "true";' > /etc/apt/apt.conf.d/90root && \
    echo 'DPkg::Options "--force-confnew";' >> /etc/apt/apt.conf.d/90root

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y curl sudo gettext

# # Use unicode
# RUN locale-gen C.UTF-8 || true
# ENV LANG=C.UTF-8

# Poetry install and configuration
ENV PATH /root/.poetry/bin:$PATH
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
# To set the desired poetry version
# RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python - --version 1.1.4
RUN poetry config virtualenvs.create false

CMD ["/bin/bash"]
