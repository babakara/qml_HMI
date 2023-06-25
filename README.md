# QML HMI界面开发

## UI设计

见Figma草图

![草图](ui/assets/figma_ui.png)

当前界面

![UI界面](ui/assets/ui.png)


## QML UI设计

UI设计完成仪表盘

剩下增加左侧数据栏：

1）定向航行,触控UI

2）路径跟踪,触控UI

3）无人艇3D动态

增加右侧地图栏：
不同地图不同QML文件
第一个地图, osm地图开发


### tiles下载

关于怎么下载OSM地图tiles，并修改成qml plugin格式的方法：
https://github.com/Moleque/qml_offline_map

## QML C++交互

待开发


## QML 3D加载obj并控制模型平移旋转

view3d的例子可以在qml中嵌入3d模型，使用mesh模型

scene3d是在qwidget中嵌入qml 3d模型，使用obj模型
参考官方wireframe例子

模型obj转mesh方法：
D:\Qt6\6.5.0\msvc2019_64\bin\balsam.exe
将obj文件拖到balsam.exe上就能生成mesh文件



