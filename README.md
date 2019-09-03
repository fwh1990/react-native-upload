# react-native-upload
一键上传 android/ios APP到各个测试平台和`app store`

### 支持系统
**MacOs**

-------

因为利用`shell`和`nodeJs`语法，而且ios只能使用Xcode处理。

### 已集成平台

>- [蒲公英](https://www.pgyer.com)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(android + ios)
>- [fir.im](https://fir.im)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(android + ios)
>- [App Store](https://appstoreconnect.apple.com) &nbsp;&nbsp;&nbsp;&nbsp;(ios)
>- [Test Flight](https://appstoreconnect.apple.com) &nbsp;&nbsp;&nbsp;(ios)

# 安装
```bash
# Npm
npm install react-native-upload --save-dev

# Yarn
yarn add react-native-upload --dev
```

# 初始化
```bash
npx upload-init
```
执行命令后会在项目根目录中创建一个`upload.json`文件，并生成以下内容：
```json5
{
    // 蒲公英
    "pgy": {
        // 上传凭证，访问链接 https://www.pgyer.com/account/api ，复制Api Key
        "pgy_api_key": "",
        "ios_export_method": "ad-hoc"
    },
    // fir.im
    "fir": {
        // 上传凭证，访问链接 https://fir.im/apps/apitoken ，复制token
        "fir_api_token": "",
        "ios_export_method": "ad-hoc"
    },
    // App Store
    "app_store": {
        // 用户（APP_ID）必须拥有该APP的上传权限
        "username": "",
        // 随机密码，访问链接 https://appleid.apple.com/account/manage ，点击 App专用密码 生成密码
        "random_password": ""
    },
    // Test Flight
    "test_flight": {
        // 用户（APP_ID）必须拥有该APP的上传权限
        "username": "",
        // 可与App Store配置共享同一个随机密码
        "random_password": "",
        "ios_export_method": "ad-hoc"
    }
}
```

`ios_export_method`即ios打包方式，一共有4中
>- app-store
>- ad-hoc
>- enterprise
>- development

# 上传方式

#### 蒲公英
```bash
npx upload-pgy
```

#### fir.im
```bash
npx upload-fir
```

#### App Store
```bash
npx upload-appstore

# 或者
npx upload-as
```

#### Test Flight
```bash
npx upload-testflight

# 或者
npx upload-tf
```

# 打包Android
针对部分平台只针对ios的情况，如果想同时打包出android的apk包，可以单独执行命令：
```bash
npx build-android
```

------

欢迎使用并给我提建议
