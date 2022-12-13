Dev Container For Arch Linux
==========

### 说明
- vscode用户设置json补充`"dev.containers.copyGitConfig": false`防止自动拷贝宿主机git配置文件到容器内（也可以通过GUI界面-设置-用户-扩展-Dev Containers-Dev>Containers: Copy Git Config 取消勾选）

- 容器创建后会自动将此项目根目录映射到容器内`/workspaces/Dev-Container-Arch-Linux`

### 开发
- 容器内git代理设置（宿主机代理需要设置允许局域网访问）
    - git config --global http.proxy 'http://[宿主机局域网IP]:7890'
    - git config --global https.proxy 'http://[宿主机局域网IP]:7890'

- vscode新建终端会进入容器内的shell，进入到容器内`/workspaces/Dev-Container-Arch-Linux`
- 此项目git已忽略目录`projects`，可创建`/workspaces/Dev-Container-Arch-Linux/projects`，并在`projects`中使用`git clone`拉取项目进行开发

- 为了保证 projects 目录下的文件性能（相比自动挂载的workspaces），需要先创建如下 volume
  > `docker volume create dev_arch_linux_data`

- 对于`projects`目录需要更新权限 `sudo chown -R [用户名] projects`

### 字体
> 为了终端图标显示正常，需要在vscode为容器对应的settings.json设置字体（[Powerline fonts](https://github.com/powerline/fonts) 中的`PL`结尾的字体也可以）
```
{
    "terminal.integrated.fontFamily": "CaskaydiaCove NF Mono"
}
```

### zsh主题
> 已安装[Powerlevel10k](https://github.com/romkatv/powerlevel10k)，如需启用请更改`.zshrc`中如下设置为
```
ZSH_THEME="powerlevel10k/powerlevel10k"
```