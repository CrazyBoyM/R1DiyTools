@ECHO OFF
TITLE R1����DIY������
color 07

:Init
	cls
	echo �ѶR1 - ����DIY������ v2.0
	echo �����ǰ���ǵ��о��������������Ż�����л�����ǵĹ������о�����
	echo �������ѿ�Դ, https://github.com/CrazyBoyM/R1DiyTools ��ӭһ������
	echo ��ȷ����ѹ�����У�����ʾadb������������������а�װadb
	echo IP3X������fx.ip3x.com (����������վ����Ҫ��¼R1������������DIY�̳�)
	echo �ٷ�QȺ�� 163063234
	echo ��ǰ·����%~dp0
	echo ################################################
	echo 1.��R1������������
	echo 2.��ʼadb����R1
	set X==
	set /p X=������������:
	if "%X%" == "" goto Init
	if "%X%" == "1" goto ConfigR1
	if "%X%" == "2" goto ConnectR1
	pause
	goto Init

:Menu
    cls
	echo ################################################
	echo ��ѡ�����
	echo 0.R1�����
	echo 1.����̼�����
	echo 2.���䰲װDLNA�����
	echo 3.���䰲װ��Χ��(����������������)
	echo 4.�鿴�������豸�б�
	echo 5.�˳�����
	echo ################################################
	set X==
	set /p X=����������:
	if "%X%" == "" goto Menu
	if "%X%" == "0" goto DNSForR1
	if "%X%" == "1" goto UpdateR1
	if "%X%" == "2" goto DLANForR1
	if "%X%" == "3" goto LightForR1
	if "%X%" == "4" (
		echo �������豸�б�
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
    set /p ip=������R1������IP��ַ(������·������̨�鿴)��
	if "%ip%" == "" goto ConnectR1
	cls
	echo ��ʼ���ӵ�%ip%:5555...
    adb kill-server
    adb connect %ip%:5555
    goto Menu

:ConfigR1
	cls
	echo ��ʼΪR1��������
	echo 1.���ذ棨��������
	echo 2.���߰棨���󶨽̳̣�
	set url=
	set X==
	set /p X=�����������ţ�
	if "%X%" == "" goto ConfigR1
	if "%X%" == "1" set url=%~dp0ext\web\wifi.html
	if "%X%" == "2" (
    	set url="https://fx.ip3x.com"
    	echo �������%url%�У������ĵȴ�
    	start "c:\progra~1\Intern~1\iexplore.exe" %url%
        )
	pause
	goto Init
	
:DNSForR1
	cls
	echo ���ű�ί��Ҷ���д�������������IP3X.COM�ṩ
	echo �󶨺����佫������ʾ����δ�󶨣��ҿ��Իָ���������ܵ�����ʹ��
	echo ��ʼ��װDNS����......
	adb shell settings put secure install_non_market_apps 1
	adb push ext\app\DNS.apk /mnt/internal_sd/
	adb shell /system/bin/pm install -r /mnt/internal_sd/DNS.apk
	adb shell sleep 10
	adb shell rm /mnt/internal_sd/DNS.apk
    echo ��ʼ�Զ�����DNS��Ԥ��1���ӣ�......
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
    
	echo ���κ���СѶСѶ����ֱ�����䲻����ʾ��δ�󶨡�
    adb shell sleep 30
	echo �����䲻��ʾ��δ�󶨡������ǳɹ��ˣ������������粢���԰�
	pause
	
    echo ���DNS����......
	adb shell settings put secure install_non_market_apps 0
	adb shell /system/bin/pm uninstall com.burakgon.dnschanger
	adb shell sleep 10
	
	goto Menu

:LightForR1
	cls
	echo ��ʼΪR1��װ��Χ��
	adb shell settings put secure install_non_market_apps 1
	adb push ext\app\EchoService.apk /mnt/internal_sd/
	adb shell /system/bin/pm install -r /mnt/internal_sd/EchoService.apk
	adb shell sleep 10
	adb shell rm /mnt/internal_sd/EchoService.apk
	adb shell settings put secure install_non_market_apps 0
	echo ��ɣ�����СѶСѶ����Χ�ơ��Կ���
	pause
	goto Menu

:DLANForR1
	cls
	echo ��ʼΪR1��װDLNA����......
	adb shell settings put secure install_non_market_apps 1
	adb push ext\app\dlna.apk /mnt/internal_sd/
	adb shell /system/bin/pm install -r /mnt/internal_sd/dlna.apk
	adb shell sleep 10
	adb shell rm /mnt/internal_sd/dlna.apk
	adb shell settings put secure install_non_market_apps 0
	echo ��ʼ�Զ�����DLNA����......
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
	echo ��ɣ����ܱ��������ͷ�ʽ���Ƚ�������Ч����
	pause
	goto Menu
	

:PushToR1
    cls
    echo �����У������ĵȴ���������
    echo ��������R1��ʾ����δ����������������Ȼ����Զ�����
    echo ������������ http://wifi.ip3x.com
    adb shell rm -rf /sdcard/otaprop.txt
    echo adb push ota\config\%~1.txt /sdcard/otaprop.txt
	adb push ota\config\%~1.txt /sdcard/otaprop.txt
	if "%~1" == "3119-3166" (
	    echo adb push ota\localRom\update_normal.zip /sdcard/update_normal.zip
	    adb push ota\localRom\update_normal.zip /sdcard/update_normal.zip
	)
	:: �ð汾����20M�������ӱ�������
    adb reboot
	pause
	goto Menu

:UpdateR1
	cls
	echo   �������ڵ�R1�����������й���CDN�ϣ�ȫ�������Ŷ
	echo   ����ݵ�ǰ�汾ѡ����ʵ��������������Ժ���СѶ�鿴����汾�ţ�
	echo   1.�� 3119 �� 3166
	echo   2.�� 3166 �� 3415
	echo   3.�� 3174 �� 3318
	echo   4.�� 3318 �� 3331
	echo   5.�� 3331 �� 3448
	echo   6.�� 3415 �� 3448
	echo   7.�鿴�������豸����ȷ�����������ӵ�R1��
	echo   8.���������ļ�
	set X=
    set /p X=�����������ţ�
	if "%X%" == "" goto UpdateR1
    if "%X%" == "1" CALL :PushToR1 "3119-3166"
    if "%X%" == "2" CALL :PushToR1 "3166-3415"
    if "%X%" == "3" CALL :PushToR1 "3174-3318"
    if "%X%" == "4" CALL :PushToR1 "3318-3331"
    if "%X%" == "5" CALL :PushToR1 "3331-3448"
    if "%X%" == "6" CALL :PushToR1 "3415-3448"
    if "%X%" == "7" (
		echo �������豸�б�
		adb devices
		pause
		goto UpdateR1
		)
    if "%X%" == "8" (
		adb shell rm -rf /sdcard/otaprop.txt 
		echo �������
		)
	pause
	goto Menu
