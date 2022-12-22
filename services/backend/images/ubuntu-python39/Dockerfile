FROM ubuntu:22.04

ARG CODE_VERSION=4.9.1

ARG PYTHON_VERSION=3.9.16

RUN mkdir /etc/sudoers.d

RUN adduser --gecos '' --disabled-password coder \
  && echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd

RUN apt-get update && \
    apt-get install -y \
    git \
    jq \
    vim \
    nano \
    net-tools \
    tmux \
    curl \
    wget \
    sudo \
    zsh \
    unzip \
    fontconfig \
    libssl-dev \
    openssl \
    build-essential \
    zlib1g-dev

RUN apt-get purge -y python3 \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && cd /tmp \
    && wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz \
    && tar -xvf Python-${PYTHON_VERSION}.tgz \
    && cd Python-${PYTHON_VERSION} \
    && ./configure --enable-optimizations \
    && make && make install \
    && ln -fs /usr/local/bin/python3 /usr/bin/python3 \
    && apt-get install -y python3-pip python3-dev

RUN pip3 install --upgrade pip && pip3 install virtualenv

RUN curl -fOL https://github.com/coder/code-server/releases/download/v${CODE_VERSION}/code-server_${CODE_VERSION}_amd64.deb

RUN dpkg -i code-server_${CODE_VERSION}_amd64.deb

USER 1000

ENV USER=coder

RUN code-server --install-extension dracula-theme.theme-dracula \
    && code-server --install-extension ms-python.python \
    && code-server --install-extension ms-python.black-formatter \
    && code-server --install-extension aaron-bond.better-comments \
    && code-server --install-extension littlefoxteam.vscode-python-test-adapter \
    && code-server --install-extension kevinrose.vsc-python-indent \
    && code-server --install-extension ms-python.isort \
    && code-server --install-extension ms-pyright.pyright \
    && code-server --install-extension coenraads.bracket-pair-colorizer-2 \
    && code-server --install-extension redhat.vscode-yaml \
    && code-server --install-extension vscode-icons-team.vscode-icons

WORKDIR /home/coder

ENV SHELL=/bin/zsh

RUN mkdir /home/coder/tmp && cd /home/coder/tmp \ 
    && sudo chsh -s ~/.zshrc \
    && wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true \
    && wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/FiraCode.zip \
    && mkdir -p /home/coder/.local/share/fonts \
    && unzip ./FiraCode.zip -d /home/coder/.local/share/fonts \
    && fc-cache -f -v \
    && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k \
    && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
    && rm -rf /home/coder/tmp

COPY --chown=coder:coder ./configs/zsh/.p10k.zsh /home/coder/.p10k.zsh

COPY --chown=coder:coder ./configs/zsh/.zshrc /home/coder/.zshrc

COPY --chown=coder:coder ./config.yaml /home/coder/.config/code-server/config.yaml

COPY --chown=coder:coder ./configs/vscode/* /home/coder/.local/share/code-server/User/

COPY --chown=coder:coder ./startup.sh /home/coder/startup.sh

EXPOSE 8080

CMD ["/bin/bash", "/home/coder/startup.sh"]