

**简要描述：** 

- 用户注册接口

**请求URL：** 
- ` oauth/regist`

**请求方式：**
- POST 

**参数：** 

|参数名|必选|类型|说明|
|:----    |:---|:----- |-----   |
|phone |是  |string |用户名   |
|password |是  |string | 密码    |


**返回示例**

``` 
{
"code": 0,
"message": "注册成功"，
"data": {
"expiryTime": "2018-12-20T10:51:32Z",
"token": "nmEtM5vh8RUAcBdbc5IS8tlzFRACSpI6HoNggEjoLIw"
}
}
```




**简要描述：** 

- 用户登录接口

**请求URL：** 
- ` oauth/login`

**请求方式：**
- POST 

**参数：** 

|参数名|必选|类型|说明|
|:----    |:---|:----- |-----   |
|phone |是  |string |用户名   |
|password |是  |string | 密码    |


**返回示例**

``` 
{
"code": 0,
"message": "验证成功"，
"data": {
"expiryTime": "2018-12-20T10:51:32Z",
"token": "nmEtM5vh8RUAcBdbc5IS8tlzFRACSpI6HoNggEjoLIw"
}
}
```



**简要描述：** 

- 获取用户个人信息

**请求URL：** 
- ` oauth/getUserInfo`

**请求方式：**
- POST 

无


**返回示例**

``` 
{
"code": 0,
"message": "验证成功"，
"data": {
"phone": "13188888885",
"password": "wahaha"
}
}
```


**简要描述：** 

- 退出登录

**请求URL：** 
- ` oauth/exit`

**请求方式：**
- POST 

无

**返回示例**

``` 
{
"code": 0,
"message": "注销成功"
}
```



