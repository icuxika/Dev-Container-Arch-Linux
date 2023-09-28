### insert模式按下<leader>卡顿
> 通过下述命令分析哪些快捷键使用了<leader>键并允许在insert模式下使用
```
:verbose imap <leader>
```

#### 重新载入文件 
```
:so
```

#### 切换窗口
```
<CTRL>hjkl
```

## 基于 keymaps.lua 所配置的快捷命令的说明（区分大小写）
#### 视觉模式v 选中几行后下移
```
<Shift>j
```

#### 视觉模式v 选中几行后上移
```
<Shift>k
```

#### 水平分割窗口
```
<Space>sv
```

#### 垂直分割窗口
```
<Space>sh
```

#### 展开或关目录树
```
<Space>e
```

#### 目录树展开或折叠子目录
```
<Tab>
```

#### 目录树打开文件
```
o
```

#### 目录树创建文件
```
a
```

#### 切换buffer（即切换打开的文件）向左
```
<Space>h
```

#### 切换buffer（即切换打开的文件）向左
```
<Space>l
```

#### 关闭当前buffer
```
<Space>q
```

#### 关闭其他buffer
```
<Space>Q
```

#### 注释与反注释单行
```
gcc
```

#### 注释与反注释多行
```
gc
```

#### Telescope文件搜索，根据文件名
```
<Space>ff
```

#### Telescope文件搜索，根据文件内容
```
<Space>fg
```

#### Telescope文件搜索，根据已打开的文件的文件名
```
<Space>fb
```

#### 视觉模式v选中多行后格式化
```
=
```

#### 显示git待提交的文件
> 在打开的窗口选中文件使用按下大写字母`X`来reset文件，通过`:tabclose`关闭diffview窗口
```
:DiffviewOpen
```

### C++
> 将`compile_commands.json`文件软连接到项目根目录方便`clangd`进行检索
```
ln -s out/build/default/compile_commands.json .
```
