#设置字符编码，防止中文乱码
chcp 65001
@echo off
::设置当前应用版本::
set version=1.0.1
:: 应用打包apk所在文件夹::
set source=D:\open-lottery\prize_lottery_app\build\app\outputs\apk\release
:: 拷贝APP文件到指定目录::
set target=D:\open-lottery\prize_lottery_apk\
:: 应用环境::
set profile=release
:: 创建拷贝文件夹::
md "%target%%version%"
echo *****************************************
echo         应用打包信息:[%version%-%profile%]
echo *****************************************
echo 开始进行应用打包...
call fvm flutter build apk --release --obfuscate --split-debug-info=%target%\symbols --dart-define=APP_PROFILE=%profile% --no-tree-shake-icons --split-per-abi
move "%source%\prize-lottery-v%version%-arm64-v8a-release.apk" "%target%%version%"
move "%source%\prize-lottery-v%version%-armeabi-v7a-release.apk" "%target%%version%"
echo 应用打包完成
pause

