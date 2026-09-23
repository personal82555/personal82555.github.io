---
title: "别再一个个注册了！开源New API自建AI聚合平台，飞牛NAS私有化布署使用"
date: 2026-09-23T06:00:00+08:00
draft: false
tags: ["软件推荐", "开源", "教程"]
categories: ["精品软件"]
slug: "别再一个个注册了-开源new-api自建ai聚合平台-飞牛nas私有化布署使用"
---

上周有个小伙伴私信我："我想自己搭一个 AI 聚合平台，给团队用，有没有开源方案？最好 Docker 一键部署的。"

我一听就笑了——**这不就是 New API 干的事吗。**

GitHub **4.7 万 Star** ，Go 语言写的，Docker 一把梭，一个平台聚合 DeepSeek、GLM、Kimi、Qwen、Grok 等 **30+ 大模型** ，统一接口、按量计费、多用户管理全都有。

今天就带你从「不懂」到「跑起来」，一步步讲清楚。

![基于 New API 搭建的 UniRoute 平台](https://img.88531.cn/i/2026/09/23/6ab343ac17d4d.png)

## 🧠 New API 是什么？一句话说清楚

**New API** （GitHub：github.com/QuantumNous/new-api）是一个开源的 **AI 大模型网关和 API 管理系统** 。

通俗理解：

  * 🏠 **完全开源** → 代码公开，想改就改，数据自己掌控
  * 🐳 **Docker 一键部署** → 一台普通服务器就能跑，不用买任何服务
  * 🔑 **一个入口** → 所有模型走同一个 API 地址，不用管后端是哪家
  * 👥 **多用户管理** → 可以给团队/朋友分配密钥，独立计费
  * 💰 **按量计费** → 每个 token 的花费清清楚楚，比买 API 套餐灵活得多

**📊 项目数据：** GitHub 47,000+ Stars / 9,600+ Forks / AGPL-3.0 开源协议 / Go 语言开发 / 支持 40+ 模型供应商 / 官方 Docker 镜像 calciumion/new-api

## 🆚 不想自建？先体验再说

如果暂时没有服务器，或者就想先试试好不好用，可以先到在线体验站感受一下：

**🎯 体验地址：** https://ai.88531.cn  
  
注册即送 ¥0.1，每天签到再领 ¥0.5，不充值也能体验 11 个模型。  
一个账号、一把密钥（sk-开头），GLM / DeepSeek / Kimi / Qwen / MiniMax 随便切。

这个体验站本身就是用 New API 搭建的，你在上面能用到的功能，自建后全都有。

![注册页面](https://img.88531.cn/i/2026/09/23/6ab343ad17a95.png)

#### ☁️ 用体验站

  * 零成本，注册即用
  * 不用管服务器
  * 适合个人体验、轻度使用
  * 数据在别人服务器上

#### 🏠 自己部署

  * 完全掌控数据和隐私
  * 不限模型数量和价格
  * 适合团队、企业、长期使用
  * Docker 一键搞定

## 🚀 Docker 一键部署（3 分钟搞定）

![文档中心](https://img.88531.cn/i/2026/09/23/6ab343acbbc18.png)

有一台 Linux 服务器（NAS、云服务器、甚至闲置笔记本都行），跟着做：

### 方式一：Docker Compose（推荐）

1 创建项目目录

# 在服务器上创建目录 mkdir -p ~/new-api && cd ~/new-api

2 创建 docker-compose.yml

cat > docker-compose.yml << 'EOF' services: new-api: image: calciumion/new-api:latest container_name: new-api ports: - "3000:3000" environment: - TZ=Asia/Shanghai volumes: - ./data:/data restart: unless-stopped EOF

3 一行命令启动

docker compose up -d

完事。打开浏览器访问 http://你的IP:3000，注册管理员账号就能用。

### 方式二：Docker Run（更简单）

docker run --name new-api -d --restart always \ -p 3000:3000 \ -e TZ=Asia/Shanghai \ -v ./data:/data \ calciumion/new-api:latest

**💡 硬件要求极低：** 1 核 CPU + 512MB 内存就能跑，家里闲置的 NAS、旧笔记本、甚至树莓派都行。数据库用自带的 SQLite，不用额外装 MySQL。

## ⚙️ 部署后：添加你的 API Key

部署好了只是第一步，关键是把你的大模型 API Key 接进来：

1 登录管理后台 → **渠道管理**  
  
2 点击 **「添加渠道」**  
  
3 填写：

  * **类型：** OpenAI（大部分国产模型也选这个）
  * **名称：** 随便写，比如"DeepSeek"
  * **密钥：** 你从 DeepSeek/智谱/阿里云等官网申请的 API Key
  * **基础 URL：** 对应厂商的 API 地址
  * **模型：** 填写你要用的模型名称

4 保存 → 在 **「令牌管理」** 创建一个令牌 → 用这个令牌调用

**常用厂商的 API 地址：**

厂商| 基础 URL| 热门模型  
---|---|---  
DeepSeek| `https://api.deepseek.com`| deepseek-chat, deepseek-reasoner  
智谱 AI| `https://open.bigmodel.cn`| glm-4-flash, glm-4-plus  
阿里云通义| `https://dashscope.aliyuncs.com/compatible-mode`| qwen-plus, qwen-turbo  
Moonshot| `https://api.moonshot.cn`| moonshot-v1-8k  
零一万物| `https://api.lingyiwanwu.com`| yi-large, yi-lightning  
SiliconFlow| `https://api.siliconflow.cn`| 有免费模型可白嫖  
  
**⚠️ Base URL 注意事项：** New API 会自动拼接 `/v1/chat/completions`，所以 URL 里不要带 `/v1`，否则会变成 `/v1/v1/...` 导致 404。

## 🎯 三大核心功能

### ① 多模型聚合 — 一个密钥走天下

不管你接了 DeepSeek、GLM、Kimi、Qwen 还是 GPT，对外只有一个 API 地址和一个密钥。调用方完全不用关心后端是哪家。

# 接入方只需要知道你的网关地址 curl https://你的地址/v1/chat/completions \ -H "Authorization: Bearer sk-你的令牌" \ -d '{ "model": "deepseek-chat", "messages": [{"role": "user", "content": "你好"}] }'

### ② 智能路由 — 自动切换、负载均衡

  * ⚡ **失败自动重试** — A 渠道挂了自动切到 B 渠道
  * ⚖️ **加权负载均衡** — 多个渠道按权重分摊流量
  * 🚫 **渠道自动禁用** — 连续超时自动下线，不影响用户
  * 📊 **可视化仪表盘** — 实时查看各渠道状态和用量

### ③ 多用户 + 计费系统 — 团队协作神器

  * 👥 **多用户管理** — 给团队成员创建独立账号
  * 🎫 **令牌分组** — 不同分组看到不同模型
  * 💰 **按量计费** — 每个 token 的花费精确到分
  * 💳 **充值系统** — 内置支付宝/微信支付，可搭建运营级平台
  * 📅 **配额管理** — 限制每个用户的使用量

## 🔌 支持的客户端

所有兼容 OpenAI 接口的客户端都能接入，配置三要素：

配置项| 填写内容  
---|---  
API 地址| `http://你的地址/v1`  
API 密钥| 网关里创建的令牌 sk-xxxxxxxx  
模型| 对应模型名（如 deepseek-chat）  
  
支持的客户端：**Cherry Studio、NextChat、LobeChat、ChatBox、OpenCat** 等几乎所有主流 AI 客户端。

## 📋 部署方式对比

方式| 适合谁| 优点| 缺点  
---|---|---|---  
Docker 一键| 大多数人| 最快、最省心| 需要会基础 Docker  
宝塔面板| 小白用户| 图形界面操作| 需要宝塔 9.2+  
源码编译| 开发者| 可深度定制| 需要 Go 环境  
MySQL 版| 生产环境| 性能更好| 需要额外装 MySQL  
  
**💡 新手建议：** 先用 Docker + SQLite 跑起来体验，觉得好用再切换到 MySQL 做生产部署。SQLite 零配置，开箱即用。

## ❓ 常见问题

**Q：需要什么服务器？家里 NAS 行不行？**

  * 完全可以。1 核 + 512MB 内存就够，群晖、威联通、绿联等 NAS 都能跑 Docker。

**Q：要花钱吗？**

  * 软件本身 **完全免费开源** 。你需要的是各家大模型的 API Key（大部分都有免费额度），按量付费。

**Q：支持哪些模型？**

  * DeepSeek、GLM（智谱）、Qwen（通义）、Kimi（月之暗面）、MiniMax、Grok、Llama、Mistral、Gemini、Claude 等 **40+ 厂商、数百个模型** 。

**Q：数据安全吗？**

  * 完全掌控。所有数据存在你自己的服务器上，请求不过第三方。适合对数据敏感的企业和团队。

**Q：能给团队用吗？**

  * 能。内置多用户系统，可以给每个人分配独立密钥和配额，按模型计费。

* * *

## 🎯 总结

一句话：**想自己掌控 AI 大模型的使用？New API 是目前最成熟的开源方案。**

  * ✅ **完全开源免费** — 4.7 万 Star，社区活跃，持续更新
  * ✅ **Docker 一键部署** — 3 分钟跑起来，NAS/旧电脑都行
  * ✅ **40+ 厂商聚合** — 一个密钥用遍 DeepSeek / GLM / Kimi / Qwen / Grok
  * ✅ **智能路由** — 失败自动切换、负载均衡、自动禁用故障渠道
  * ✅ **多用户计费** — 团队协作、按量计费、令牌分组
  * ✅ **数据自控** — 所有数据在自己服务器上，不依赖第三方

**🔗 相关链接：**  
• GitHub：github.com/QuantumNous/new-api  
• Docker 镜像：hub.docker.com/r/calciumion/new-api  
• 在线体验：https://ai.88531.cn（注册送 ¥0.1，每天签到领 ¥0.5）

**⚠️ 安全提醒：** 部署后记得修改管理员默认密码。API 密钥不要泄露到公开仓库（GitHub）。建议配置 HTTPS 后再开放到公网。