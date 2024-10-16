感谢大佬

[https://linux.do/t/topic/229803](https://linux.do/t/topic/229803)

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

<table>
<thead>
<tr>
<th>变量名</th>
<th>描述</th>
<th>默认值</th>
</tr>
</thead>
<tbody>
<tr>
<td>GIST_PAT</td>
<td>github gist 读写权限 token</td>
<td></td>
</tr>
<tr>
<td>GIST_LINK</td>
<td>github username/gist id</td>
<td></td>
</tr>
<tr>
<td>PROXY</td>
<td>代理地址，海外服务器可不设置此值</td>
<td></td>
</tr>
<tr>
<td>CUSTOMIZE_LINK</td>
<td>自己维护的机场网址，每行包含域名、优惠券和邀请码，域名必填，后两项可选</td>
<td></td>
</tr>
<tr>
<td>ENABLE_SPECIAL_PROTOCOLS</td>
<td>包括特殊协议，例如 vless hysteria2 和 hysteria</td>
<td>true</td>
</tr>
<tr>
<td>TZ</td>
<td>时区</td>
<td><code>Asia/Shanghai</code></td>
</tr>
<tr>
<td>CRON_RULE</td>
<td>定时规则</td>
<td><code>0 */2 * * *</code></td>
</tr>
</tbody>
</table>
