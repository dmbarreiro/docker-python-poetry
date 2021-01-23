FROM python:3.9

# make Apt non-interactive
RUN echo 'APT::Get::Assume-Yes "true";' > /etc/apt/apt.conf.d/90poetry && \
    echo 'DPkg::Options "--force-confnew";' >> /etc/apt/apt.conf.d/90poetry

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y curl sudo

# Use unicode
RUN locale-gen C.UTF-8 || true
ENV LANG=C.UTF-8

RUN groupadd --gid 5432 poetry && \
    useradd --uid 5432 --gid poetry --shell /bin/bash --create-home poetry && \
    echo 'poetry ALL=NOPASSWD: ALL' >> /etc/sudoers.d/50-poetry

USER poetry

# Poetry install and configuration
ENV PATH /home/poetry/.poetry/bin:$PATH
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python - 
RUN poetry config virtualenvs.create false

CMD ["/bin/bash"]
