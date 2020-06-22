@ECHO OFF
TITLE R1极客DIY工具箱
color 07

:Init
	cls
	echo 斐讯R1 - 极客DIY工具箱 v2.0
	echo 借鉴了前辈们的研究并进行了整理优化，感谢大神们的贡献与研究精神
	echo 本工具已开源, https://github.com/CrazyBoyM/R1DiyTools 欢迎一起完善
	echo 请确保解压后运行，如提示adb命令不是内置命令请自行安装adb
	echo IP3X官网：fx.ip3x.com (公益性质网站，主要收录R1绑定配网升级等DIY教程)
	echo 官方Q群： 163063234
	echo 当前路径：%~dp0
	echo ################################################
	echo 1.给R1音箱配置网络
	echo 2.开始adb连接R1
	set X==
	set /p X=请输入操作编号:
	if "%X%" == "" goto Init
	if "%X%" == "1" goto ConfigR1
	if "%X%" == "2" goto ConnectR1
	pause
	goto Init

:Menu
    cls
	echo ################################################
	echo 请选择操作
	echo 0.R1音箱绑定
	echo 1.音箱固件更新
	echo 2.音箱安装DLNA服务端
	echo 3.音箱安装氛围灯(仅适用于蓝牙播放)
	echo 4.查看已连接设备列表
	echo 5.退出工具
	echo ################################################
	set X==
	set /p X=输入操作编号:
	if "%X%" == "" goto Menu
	if "%X%" == "0" goto DNSForR1
	if "%X%" == "1" goto UpdateR1
	if "%X%" == "2" goto DLANForR1
	if "%X%" == "3" goto LightForR1
	if "%X%" == "4" (
		echo 以下是设备列表
		adb devices
		pause
		goto Menu
		)
	if "%X%" == "5" exit
	pause
	goto Menu
	

:ConnectR1
    cls
	set PATH=%PATH%;%~dp0lib\windows\
  	::echo %PATH%
	set ip =
    set /p ip=请输入R1的内网IP地址(可以在路由器后台查看)：
	if "%ip%" == "" goto ConnectR1
	cls
	echo 开始连接到%ip%:5555...
    adb kill-server
    adb connect %ip%:5555
    goto Menu

:ConfigR1
	cls
	echo 开始为R1进行配置
	echo 1.本地版（仅配网）
	echo 2.在线版（含绑定教程）
	set url=
	set X==
	set /p X=请输入操作编号：
	if "%X%" == "" goto ConfigR1
	if "%X%" == "1" set url=%~dp0ext\web\wifi.html
	if "%X%" == "2" (
    	set url="https://fx.ip3x.com"
    	echo 浏览器打开%url%中，请耐心等待
    	start "c:\progra~1\Intern~1\iexplore.exe" %url%
        )
	pause
	goto Init
	
:DNSForR1
	cls
	echo 本脚本委托叶神编写，公益服务器由IP3X.COM提供
	echo 绑定后音箱将不会提示音箱未绑定，且可以恢复大多数功能的正常使用
	echo 开始安装DNS工具......
	adb shell settings put secure install_non_market_apps 1
	adb push ext\app\DNS.apk /mnt/internal_sd/
	adb shell /system/bin/pm install -r /mnt/internal_sd/DNS.apk
	adb shell sleep 10
	adb shell rm /mnt/internal_sd/DNS.apk
    echo 开始自动配置DNS（预计1分钟）......
    adb shell am start -n com.burakgon.dnschanger/com.burakgon.dnschanger.activities.MainActivity
    adb shell sleep 10
    
    adb shell input tap 100 470
    adb shell sleep 3
    
    adb shell input tap 100 120
    adb shell sleep 3
    
    adb shell input tap 100 130
    adb shell sleep 3
    
    adb shell input tap 150 180
    adb shell input keyevent 67
    adb shell input keyevent 67
    adb shell input keyevent 67
    adb shell input keyevent 67
    adb shell input keyevent 67
    adb shell input keyevent 67
    adb shell input keyevent 67
    adb shell input keyevent 67
    adb shell input keyevent 67
    adb shell input keyevent 67
    adb shell input keyevent 67
    adb shell input keyevent 67
    adb shell sleep 3
    
    adb shell input text 47.240.76.176
    adb shell sleep 3
    
    adb shell input tap 150 280
    adb shell sleep 3
    
    adb shell input tap 530 350
    adb shell sleep 15
    
    adb shell ping aios-home.hivoice.cn
    adb shell ping www.baidu.com
    adb shell sleep 3
    
	echo 请多次喊“小讯小讯”，直到音箱不再提示“未绑定”
    adb shell sleep 30
	echo 若音箱不提示“未绑定”，就是成功了，否则请检查网络并重试绑定
	pause
	
    echo 清除DNS工具......
	adb shell settings put secure install_non_market_apps 0
	adb shell /system/bin/pm uninstall com.burakgon.dnschanger
	adb shell sleep 10
	
	goto Menu

:LightForR1
	cls
	echo 开始为R1安装氛围灯
	adb shell settings put secure install_non_market_apps 1
	adb push ext\app\EchoService.apk /mnt/internal_sd/
	adb shell /system/bin/pm install -r /mnt/internal_sd/EchoService.apk
	adb shell sleep 10
	adb shell rm /mnt/internal_sd/EchoService.apk
	adb shell settings put secure install_non_market_apps 0
	echo 完成，喊“小讯小讯，氛围灯”以开启
	pause
	goto Menu

:DLANForR1
	cls
	echo 开始为R1安装DLNA服务......
	adb shell settings put secure install_non_market_apps 1
	adb push ext\app\dlna.apk /mnt/internal_sd/
	adb shell /system/bin/pm install -r /mnt/internal_sd/dlna.apk
	adb shell sleep 10
	adb shell rm /mnt/internal_sd/dlna.apk
	adb shell settings put secure install_non_market_apps 0
	echo 开始自动配置DLNA服务......
	adb shell am start -n com.droidlogic.mediacenter/.MediaCenterActivity
	adb shell sleep 10
	adb shell input tap 100 150
	adb shell sleep 1
	adb shell input tap 100 150
	adb shell sleep 1
	adb shell input tap 500 100
	adb shell sleep 1
	adb shell input tap 500 150
	adb shell sleep 1
	adb shell input tap 100 200
	adb shell sleep 1
	adb shell input tap 500 100
	adb shell sleep 1
	adb shell input tap 500 150
	echo 完成，享受比蓝牙推送方式更先进的音质效果吧
	pause
	goto Menu
	

:PushToR1
    cls
    echo 升级中，请耐心等待音箱重启
    echo 重启后若R1提示网络未连接请重新配网，然后会自动升级
    echo 在线配网工具 http://wifi.ip3x.com
    adb shell rm -rf /sdcard/otaprop.txt
    echo adb push ota\config\%~1.txt /sdcard/otaprop.txt
	adb push ota\config\%~1.txt /sdcard/otaprop.txt
	if "%~1" == "3119-3166" (
	    echo adb push ota\localRom\update_normal.zip /sdcard/update_normal.zip
	    adb push ota\localRom\update_normal.zip /sdcard/update_normal.zip
	)
	:: 该版本大于20M，单独从本地推送
    adb reboot
	pause
	goto Menu

:UpdateR1
	cls
	echo   本工具内的R1音箱升级包托管在CDN上，全球公益加速哦
	echo   请根据当前版本选择合适的升级操作（可以呼唤小讯查看软件版本号）
	echo   1.从 3119 到 3166
	echo   2.从 3166 到 3415
	echo   3.从 3174 到 3318
	echo   4.从 3318 到 3331
	echo   5.从 3331 到 3448
	echo   6.从 3415 到 3448
	echo   7.查看已连接设备（请确保已正常连接到R1）
	echo   8.清理升级文件
	set X=
    set /p X=请输入操作编号：
	if "%X%" == "" goto UpdateR1
    if "%X%" == "1" CALL :PushToR1 "3119-3166"
    if "%X%" == "2" CALL :PushToR1 "3166-3415"
    if "%X%" == "3" CALL :PushToR1 "3174-3318"
    if "%X%" == "4" CALL :PushToR1 "3318-3331"
    if "%X%" == "5" CALL :PushToR1 "3331-3448"
    if "%X%" == "6" CALL :PushToR1 "3415-3448"
    if "%X%" == "7" (
		echo 以下是设备列表
		adb devices
		pause
		goto UpdateR1
		)
    if "%X%" == "8" (
		adb shell rm -rf /sdcard/otaprop.txt 
		echo 清理完成
		)
	pause
	goto Menu
