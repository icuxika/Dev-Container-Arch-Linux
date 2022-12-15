FROM archlinux

ADD /.devcontainer/mirrorlist /etc/pacman.d/mirrorlist

RUN pacman-key --init
RUN yes | pacman -Syy
RUN yes | pacman -S archlinux-keyring
RUN yes | pacman -Syu
RUN yes | pacman -S git zsh vim sudo wget

ENV SHELL /bin/zsh

# root passwd
ARG ROOT_PASSWD=root
RUN echo "root:${ROOT_PASSWD}" | chpasswd
# non-root user
ARG USERNAME=icuxika
RUN useradd -m -G wheel -s /bin/zsh $USERNAME
RUN echo "${USERNAME}:${USERNAME}" | chpasswd
# RUN echo "%${USERNAME} ALL=(ALL:ALL) ALL" >> /etc/sudoers
RUN echo "%${USERNAME} ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
USER $USERNAME
WORKDIR /home/$USERNAME

ARG A_HTTP_PROXY
ARG A_HTTPS_PROXY

RUN export https_proxy=$A_HTTPS_PROXY && wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O - | zsh || true

RUN export https_proxy=$A_HTTPS_PROXY && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /home/$USERNAME/.oh-my-zsh/custom/themes/powerlevel10k \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/$USERNAME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting \
    && git clone https://github.com/zsh-users/zsh-autosuggestions.git /home/$USERNAME/.oh-my-zsh/custom/plugins/zsh-autosuggestions \
    && git clone https://github.com/zsh-users/zsh-completions.git /home/$USERNAME/.oh-my-zsh/custom/plugins/zsh-completions \
    && git clone https://github.com/supercrabtree/k.git /home/$USERNAME/.oh-my-zsh/custom/plugins/k

ADD --chown=$USERNAME /.devcontainer/.zshrc /home/$USERNAME
ADD --chown=$USERNAME /.devcontainer/.vimrc /home/$USERNAME

# nvm
ARG NODE_VERSION
RUN export https_proxy=$A_HTTPS_PROXY && wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash || true
RUN source /home/$USERNAME/.nvm/nvm.sh \
    nvm install $NODE_VERSION

# fzf
RUN yes | sudo pacman -S fzf
RUN echo '' >> /home/$USERNAME/.zshrc &&\
    echo '# fzf' >> /home/$USERNAME/.zshrc &&\
    echo 'source /usr/share/fzf/key-bindings.zsh' >> /home/$USERNAME/.zshrc &&\
    echo 'source /usr/share/fzf/completion.zsh' >> /home/$USERNAME/.zshrc
