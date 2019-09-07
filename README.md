# react-native-upload
一键上传 android/ios APP到各个测试平台和`app store`

### 支持系统
**MacOs**

-------

因为使用了`shell`语法，而且ios只能依赖Xcode处理。

### 已集成平台

>- [蒲公英](https://www.pgyer.com)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(android + ios)
>- [fir.im](https://fir.im)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(android + ios)
>- [App Store](https://appstoreconnect.apple.com) &nbsp;&nbsp;&nbsp;&nbsp;(ios)
>- [Test Flight](https://developer.apple.com/testflight/) &nbsp;&nbsp;&nbsp;(ios)

# 安装
```bash
# Npm
npm install react-native-upload --save-dev

# Yarn
yarn add react-native-upload --dev
```

# 初始化
先执行这个命令：
```bash
npx upload-init
```
执行命令后会在项目根目录中创建一个`upload.json`文件，并生成以下内容：
```json5
// 未用到的配置，可以置空不填写，也可以直接删除
{
    // 上传到蒲公英
    "pgy": {
        // 上传凭证，访问链接 https://www.pgyer.com/account/api ，复制Api Key
        "pgy_api_key": "",
        "ios_export_method": "ad-hoc"
    },
    // 上传到fir.im
    "fir": {
        // 上传凭证，访问链接 https://fir.im/apps/apitoken ，复制token
        "fir_api_token": "",
        "ios_export_method": "ad-hoc"
    },
    // 上传到App Store
    "app_store": {
        // 用户（APP_ID）必须拥有该APP的上传权限
        "username": "",
        // 随机密码，访问链接 https://appleid.apple.com/account/manage ，点击 App专用密码 生成密码
        "random_password": ""
    },
    // 上传到Test Flight
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

# 自动打包上传

### 蒲公英
```bash
npx upload-pgy

# 填写更新日志
npx upload-pgy --log "增加xxx功能"

# 忽略平台
npx upload-pgy --no-android
npx upload-pgy --no-ios
```

### fir.im
```bash
npx upload-fir

# 填写更新日志
npx upload-fir --log "增加xxx功能"

# 忽略平台
npx upload-fir --no-android
npx upload-fir --no-ios
```

### App Store
请确保已经在xcode中处理好签名和证书。最简单有效的方式就是您在xcode中手动打包并导出一份ipa文件，如果成功，那么自动打包也不会有问题。
```bash
npx upload-appstore

# 或者缩写
npx upload-as
```

### Test Flight
```bash
npx upload-testflight

# 或者缩写
npx upload-tf
```

# 只打包不上传
由于某种原因，您只想安安静静地打包出app而不上传到任何平台，您可以用以下指令处理您的需求：

### 同时打包android和ios
```bash
npx upload-build --ios-export-metohd xxx
```
`--ios-export-method`可选择为下列数据中任意一个：
>- app-store
>- ad-hoc
>- enterprise
>- development


### 单独打包android
```bash
npx upload-build-android
```

### 单独打包ios
```bash
npx upload-build-ios --ios-export-metohd xxx
```

------

欢迎使用并给我提建议
