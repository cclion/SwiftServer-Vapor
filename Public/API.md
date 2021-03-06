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
<h2 id="文章">文章</h2>

文章相关接口包括上传文章、获取个人文章列表。

<h3 id="上传文章">上传文章</h3>

> article/addArticle

##### 请求方式：POST

##### 请求参数

|参数|必选|类型|说明|
|:--|:---|:---|:--- |
| title | 是 | string | 标题 |
| content | 是 | string | 文本内容 |
| image | 否 | string | 图片地址 |



##### 返回字段

|返回字段|字段类型|说明 |
|:----- |:------|:---|
| code | int | 0 = 成功 |
| message | string | 添加成功|


##### 返回示例


```
{
"status": 0,
"message": "添加成功"
}
```
<h3 id="获取个人文章列表">获取个人文章列表</h3>

> article/getArticles

##### 请求方式：POST

##### 请求参数

`无`

##### 返回字段

|返回字段|字段类型|说明 |
|:----- |:------|:---|
| id | int | 文章id |
| title | string | 文章标题 |
| content | string | 文章内容 |
| image | string | 图片内容 |
| userID | int | 用户ID |



##### 返回示例


```
{
"status": 0,
"message": "添加成功",
"data": [
{
"id": 1,
"title": "title",
"content": "这是文本",
"userID": 7
},
{
"id": 2,
"title": "title",
"content": "这是文本",
"userID": 7
}
]

}
```
<h2 id="图片">图片</h2>

图片相关接口包括上传图片、获取图片。

<h3 id="上传图片">上传图片</h3>

> image/updateImage

##### 请求方式：POST

##### 请求参数

|参数|必选|类型|说明|
|:--|:---|:---|:--- |
| image | 是 | File | 图片文件 |

##### 返回字段

|返回字段|字段类型|说明 |
|:----- |:------|:---|
| code | int | 0 = 成功 |
| message | string | 添加成功 |
| imageStr | string | 图片地址绝对路径 |

##### 返回示例

```
{
"status": 0,
"message": "添加成功"
}
```

<h3 id="获取图片">获取图片</h3>

> image/imageStr

##### 请求方式：Get

##### 请求参数

|参数|必选|类型|说明|
|:--|:---|:---|:--- |
| / | 是 | string | 图片地址 |

##### 返回字段

|返回字段|字段类型|说明 |
|:----- |:------|:---|
| / | File  | 图片文件 |


##### 返回示例

```
我是一张图片
```
