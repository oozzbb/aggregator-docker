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
