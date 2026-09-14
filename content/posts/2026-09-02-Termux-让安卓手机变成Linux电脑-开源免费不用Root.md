---
title: "Termux：让安卓手机变成Linux电脑，开源免费不用Root"
date: 2026-09-02T06:00:00+08:00
draft: false
tags: ["软件推荐", "开源"]
categories: ["手机软件"]
slug: "termux-让安卓手机变成linux电脑-开源免费不用root"
---

# Termux：让安卓手机变成Linux电脑，开源免费不用Root

![封面图](https://img.88531.cn/i/2026/09/02/6a97683cca7ee.jpg)

你有没有想过，你的安卓手机其实能跑Linux命令？不用刷机、不用Root，装一个APP就能在手机上用Python写代码、用Git管理项目、用SSH远程连接服务器……听起来是不是很酷？

今天介绍的这款**Termux** ，就是这么一个神奇的安卓终端模拟器。它开源免费，GitHub上拥有超过50K星，是全球安卓玩机圈和开发者必备的工具。

## Termux到底能干啥？

简单来说，Termux在你的手机上模拟了一个Linux终端环境。打开它，你看到的就是一个和电脑上几乎一模一样的命令行界面。

![Termux界面](https://img.88531.cn/i/2026/09/02/6a9768a28def0.png)

它能做的事情包括但不限于：

  * 💻 **写代码** ：支持Python、Node.js、C/C++、Rust、Go等几乎所有主流语言
  * 💻 **远程连接** ：通过SSH连接到你的服务器，随时随地管理
  * 💻 **文件管理** ：用命令行高效管理手机文件
  * 💻 **安装工具** ：通过APT包管理器安装各种Linux工具（Git、Vim、Nano等）
  * 💻 **自动化脚本** ：写Shell脚本批量处理任务

![Termux使用](https://img.88531.cn/i/2026/09/02/6a9768a987cf2.png)

## 怎么安装和使用？

**第一步：下载安装**

⚠️ 重要提醒：Google Play上的Termux版本已经很久没更新了！建议从F-Droid或GitHub下载最新版。

  1. 打开 `f-droid.org`，搜索 Termux
  2. 下载对应你手机架构的APK（一般选 arm64-v8a）
  3. 正常安装即可

**第二步：换国内镜像源**

这一步很关键！默认的官方源在国内下载速度很慢。打开Termux，执行：
[code] 
    termux-change-repo
[/code]

进入图形界面后，选择清华镜像源（Mirrors by Tsinghua），回车确认即可。

**第三步：开始使用**

换完源后，你就可以像在Linux电脑上一样操作了：
[code] 
    # 更新软件包
    pkg update && pkg upgrade
    
    # 安装Python
    pkg install python
    
    # 运行Python脚本
    python3 hello.py
    
    # 安装Git
    pkg install git
    
    # SSH连接服务器
    ssh user@your-server.com
[/code]

## 适合谁用？

Termux特别适合这几类人：

  * 🧑‍💻 **开发者** ：出门在外也能写代码、管理服务器
  * 📱 **玩机爱好者** ：在手机上体验完整的Linux环境
  * 🎓 **学生党** ：没电脑也能学Python、学Linux命令
  * 🔧 **运维人员** ：手机SSH连服务器，随时随地处理问题

而且Termux完全不需要Root权限（虽然Root后能解锁更多高级功能），普通用户也能直接上手。

## 一些实用小技巧

  * 💡 长按屏幕可以复制粘贴
  * 💡 左侧滑动可以打开多终端窗口
  * 💡 底部工具栏有Ctrl、Esc等快捷键
  * 💡 输入 `termux-setup-storage` 可以获取手机存储权限
  * 💡 安装 `oh-my-zsh` 可以获得更漂亮的终端体验

说实话，Termux这个工具真的太被低估了。它把一台普通的安卓手机变成了一个随身携带的Linux工作站，而且完全开源免费。如果你对命令行感兴趣，或者需要随时随地管理服务器，Termux绝对值得你安装。

## 下载方式

夸克网盘下载：（夸克Cookie未配置，请手动搜索Termux下载）

F-Droid下载（推荐）：<https://f-droid.org/packages/com.termux/>

GitHub下载：<https://github.com/termux/termux-app/releases>

**💬 关注公众号：「实用软技」，在公众号窗口里回复关键字「软件」即可免费获取**