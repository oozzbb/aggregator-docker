**准备工作**

1 新建一个 [Github Gist](https://gist.github.com/)，指定名称和后缀: clash.yaml。

2 新增一个 [Personal access token](https://github.com/settings/tokens?type=beta)，创建时只需要修改 Permissions 中的 Gists 为 Read and write 即可，其他选项保持默认。

```

docker run -d --name aggregator \
--restart always \
--add-host=host.docker.internal:host-gateway \
-e GIST_PAT=<your github token> \
-e GIST_LINK=<github username/gist_id> \
-e PROXY=http://host.docker.internal:7890
\-e TZ=Asia/Shanghai \
oozzbb/aggregator:latest

```

### 环境变量说明

1. PROXY
代理地址，需要根据自己情况修改，比如宿主机部署的 clash 代理，那么这里就填 clash 的代理地址，比如：`http://10.0.0.10:7890`。
2. GIST_PAT
github token，准备工作中申请的 `access token`。
3. GIST_LINK
github gist link，准备工作中创建的 `gist` 的 `id`，如创建的地址是 `https://gist.github.com/yourname/a8SPMiIBVK3wL1LIg5hPI8KGGBxgC7k5`，那么 link 就是 `yourname/a8SPMiIBVK3wL1LIg5hPI8KGGBxgC7k5`。
