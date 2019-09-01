# react-native-upload
一键上传 android/ios APP到各个测试平台和`app store`

### 支持系统
**MacOs**

-------

因为利用`shell`和`nodeJs`语法，而且ios只能使用Xcode处理。

### 已集成平台

>- [蒲公英](https://www.pgyer.com) 

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
    // 蒲公英配置
    "pgy": {
        // 上传凭证，访问链接 https://www.pgyer.com/account/api ，复制Api Key
        "pgy_api_key": "",
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

------

欢迎使用并给我提建议
