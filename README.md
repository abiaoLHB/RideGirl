## 目录结构

```
.
├── common/                     # app 通用功能
│   ├── api.js                  # 所有页面的后台调用
│   ├── urls.js                 # 所有的 api 接口地址
│   └── oss.js                  # oss 图片上传功能，此 app 暂时不需要
├── components/                 # 公共组件
│   ├── popup/                  # 底部弹窗组件
│   ├── pay/                    # 支付组件
│   ├── toast/                  # toast 组件 
│   └── styles/                 # 组件共享的样式
├── img/                        # 图片资源
├── libs/                       # 各种第三方库，目前仅包括微信授权登录 SDK
├── pages/                      # 业务页面
│   └── ...
├── styles/                     # 公共样式文件，包括 weui-wxss 和一些自定义样式类
├── utils/                      # 工具类，里面不包含任何 HTTP 调用
└── README.md
```

## 工具类使用说明

```js
/** 引入到当前页面 */
import utils from '../../utils/index'

const options = {}
utils.canvas.draw(options)
```

## 编码规范

以下是推荐使用的编码规范

- 使用 ES6 语法和模块规范
- 没有结尾分号

## 样式说明

`app.wxss` 已经定义了一些全局样式属性，直接引用即可。

如果需要覆盖全局样式，在各自页面的 `index.wxss` 编写即可。

## `app.getGid()`

有的页面需要获取当前的群组 ID，可以使用 `app.getGid()` 获取。该函数返回一个 `Promise`，举例如下：

```js
function foo() {
    // ...
    const app = getApp()
    app.getGid()
        .then(gid => {
            console.log(gid)
            // Do something...
        })
}
```

⚠️ 注意：只有分享给群组时，gid 才有值。若分享给好友，gid 可能返回 `null`。注意做好空值的判断处理。
