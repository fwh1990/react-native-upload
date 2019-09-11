# react-native-upload
一键上传 android/ios APP到各个测试平台和`app store`

### 支持系统
**MacOs**

-------

因为使用了`shell`语法，而且ios只能依赖MacOs系统处理。

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
        "ios_export_plist": "./ios-export/ad-hoc.plist"
    },
    // 上传到fir.im
    "fir": {
        // 上传凭证，访问链接 https://fir.im/apps/apitoken ，复制token
        "fir_api_token": "",
        "ios_export_plist": "./ios-export/ad-hoc.plist"
    },
    // 上传到App Store
    "app_store": {
        // 用户（APP_ID）必须拥有该APP的上传权限
        "username": "",
        // 随机密码，访问链接 https://appleid.apple.com/account/manage ，点击 App专用密码 生成密码
        "random_password": "",
        "ios_export_plist": "./ios-export/app-store.plist"
    },
    // 上传到Test Flight
    "test_flight": {
        // 用户（APP_ID）必须拥有该APP的上传权限
        "username": "",
        // 可与App Store配置共享同一个随机密码
        "random_password": "",
        "ios_export_plist": "./ios-export/ad-hoc.plist"
    }
}
```

# ios_export_plist

ios的打包配置因人而异，在允许自动打包之前，为保证能准确无误地打包出符合要求的app，需要您先手动处理一次（只需一次）。

### 1、手动打包
点击 `Xcode -> Product -> Archive`，等待打包完成
### 2、导出app
点击 `Xcode -> Window -> Organizer`，选择刚才打的包，点击右边按钮`Distribute App`，进行一系列选择之后，最后点击`Export`按钮，把文件下载到本地磁盘。

一般来说，您可能需要手动导出两份app文件：

>- 如果您想把app上传到测试平台，请尽量选择`Ad Hoc`的打包方式
>- 如果您想把app上传到App Store，请选择`ios App Store`的打包方式

### 3、复制文件
导出的app目录中大致包含如下内容：
![](https://github.com/fwh1990/react-native-upload/blob/master/example.png?raw=true)

请将文件`ExportOptionns.plist`复制到项目中，并保持与配置`ios_export_plist`所指向的路径一致。推荐您将文件重命名为打包方式的名称，如`ad-hoc`、`app-store`等。

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
npx upload-build --ios-export-plist path/to/xxx.plist
```


### 单独打包android
```bash
npx upload-build-android
```

### 单独打包ios
```bash
npx upload-build-ios --ios-export-plist path/to/xxx.plist
```

------

欢迎使用并给我提建议
