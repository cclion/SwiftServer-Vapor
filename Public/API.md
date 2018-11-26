<h2 id="用户">用户</h2>

用户相关接口包括登录、注册、获取个人信息、退出登录。

<h3 id="注册">注册</h3>

> oauth/regist

##### 请求方式：POST

##### 请求参数

|参数|必选|类型|说明|
|:--|:---|:---|:--- |
| phone | 是 | string | 账号 |
| password | 是 | string | 密码 |

##### 返回字段

|返回字段|字段类型|说明 |
|:----- |:------|:---|
| code | int | 0 = 验证成功 |
| message | string | 描述字段 |
| data | string | 登录成功返回 Token |

##### 返回示例


```
{
"status": 0,
"message": "验证成功",
"data": {
"expiryTime": "2018-12-20T10:51:32Z",
"token": "nmEtM5vh8RUAcBdbc5IS8tlzFRACSpI6HoNggEjoLIw"
}
}
```

<h3 id="登录">登录</h3>

> oauth/login

##### 请求方式：POST

##### 请求参数

|参数|必选|类型|说明|
|:--|:---|:---|:--- |
| phone | 是 | string | 账号 |
| password | 是 | string | 密码 |

##### 返回字段

|返回字段|字段类型|说明 |
|:----- |:------|:---|
| code | int | 0 = 请求成功 |
| message | string | 描述字段 |
| data | string | 注册成功则返回 Token |

##### 返回示例


```
{
"status": 0,
"message": "注册成功",
"data": {
"expiryTime": "2018-12-20T10:51:32Z",
"token": "nmEtM5vh8RUAcBdbc5IS8tlzFRACSpI6HoNggEjoLIw"
}
}
```

<h3 id="获取用户个人信息">获取用户个人信息</h3>

> oauth/getUserInfo

##### 请求方式：POST

##### 请求参数

`无`

##### 返回字段

|返回字段|字段类型|说明 |
|:----- |:------|:---|
| code | int | 0 = 验证成功 |
| message | string | 描述字段 |
| phone | string | 注册手机号 |

##### 返回示例


```
{
"status": 0,
"message": "注册成功",
"data": {
"phone": "13188888885"
}
}
```
<h3 id="退出登录">退出登录</h3>

> oauth/exit

##### 请求方式：POST

##### 请求参数

`无`

##### 返回字段

|返回字段|字段类型|说明 |
|:----- |:------|:---|
| code | int | 0 = 验证成功 |
| message | string | 描述字段 |

##### 返回示例


```
{
"status": 0,
"message": "注册成功"
}
```
