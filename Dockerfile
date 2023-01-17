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
ENV PATH /root/.local/bin:$PATH
RUN curl -sSL https://install.python-poetry.org | python3 - --version 1.3.2
RUN poetry config virtualenvs.create false

CMD ["/bin/bash"]
