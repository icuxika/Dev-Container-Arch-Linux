
## 初始化步骤
> 由于配置了镜像源后以下命令放在Dockerfile自动构建会出现莫名的错误，暂时手动执行
```
pacman-key --init
pacman -Syy
pacman -S archlinux-keyring
pacman -Syu
pacman -S git zsh vi sudo
```