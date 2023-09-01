# Dev Container For Arch Linux

### 说明

- vscode 用户设置 json 补充`"dev.containers.copyGitConfig": false`防止自动拷贝宿主机 git 配置文件到容器内（也可以通过 GUI 界面-设置-用户-扩展-Dev Containers-Dev>Containers: Copy Git Config 取消勾选）

- 容器创建后会自动将此项目根目录映射到容器内`/workspaces/Dev-Container-Arch-Linux`

### 配置（容器内可以通过宿主机的局域网 ip 访问宿主机端口，梯子要开放局域网连接）

- 创建文件`.devcontainer/devcontainer.env`（此文件为了不同电脑不同配置而不被 VCS 管理），配置如下环境变量（用于梯子指定，直接设置 HTTP_PROXY 和 HTTPS_PROXY 的话会导致`pacman`执行产生一些问题）

```
A_HTTP_PROXY=http://192.168.1.84:7890
A_HTTPS_PROXY=http://192.168.1.84:7890
```

### 开发

- 为了保证 projects 目录下的文件性能（相比自动挂载的 workspaces），需要先创建如下 volume

  > `docker volume create dev_arch_linux_data`

- 容器内 git 代理设置（宿主机代理需要设置允许局域网访问，`配置`中设置的环境变量可以通过`printenv`命令查看）

  - `git config --global http.proxy $A_HTTP_PROXY`
  - `git config --global https.proxy $A_HTTP_PROXY`

- vscode 新建终端会进入容器内的 shell，进入到容器内`/workspaces/Dev-Container-Arch-Linux`

- 由于`devcontainer.json`中的`mounts`设置，容器内会自动创建`/workspaces/Dev-Container-Arch-Linux/projects`，但是目录的权限属于`root`

  > 对于`projects`目录需要更新权限 `sudo chown -R [用户名] projects`，目前已经在`postCreateCommand`中调用，使用时请调整用户名

- 在`projects`中使用`git clone`拉取项目进行开发

### 字体

> 为了终端图标显示正常，需要在`devcontainer.json`中配置终端字体，本项目配置的字体可以通过[Nerd-Fonts-Fork-CascadiaCode（对于 Nerd Fonts 的部分 fork）](https://github.com/icuxika/Nerd-Fonts-Fork-CascadiaCode)获取，更多字体可以查看[Nerd Fonts](https://github.com/ryanoasis/nerd-fonts)

```
"settings": {
  "terminal.integrated.fontFamily": "CaskaydiaCove NF Mono"
},
```

### zsh 主题

> 已安装[Powerlevel10k](https://github.com/romkatv/powerlevel10k)，如需启用请更改`.zshrc`中如下设置为

```
ZSH_THEME="powerlevel10k/powerlevel10k"
```

### 在容器内开启 sshd 服务

1. 在`devcontainer.json`文件中补充

```
"appPort": "2222:22",
```

2. 更新系统依赖并安装`openssh`

```
sudo pacman -Syu
xpacs
```

3. 在容器内的系统创建文件`enable_sshd.sh`

```
echo "PasswordAuthentication yes" | sudo tee -a /etc/ssh/sshd_config
sudo /usr/bin/ssh-keygen -A
nohup sudo /usr/bin/sshd -D &
```

4. 执行`enable_sshd.sh`（第一次启动）

```
sudo bash enable_sshd.sh
```

5. 容器重启后

```
nohup sudo /usr/bin/sshd -D &
```

6. 补充说明，无法使用 systemctl

```
sudo systemctl status sshd
sudo systemctl start sshd
sudo systemctl stop sshd
```

会提示如下错

> System has not been booted with systemd as init system (PID 1). Can't operate.

> Failed to connect to bus: Host is down
