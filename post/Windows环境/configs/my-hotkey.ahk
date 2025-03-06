; 	# 号代表 Win 键；
; 	! 号代表 Alt 键；
;	^ 号代表 Ctrl 键；
;	+ 号代表 shift 键；
;	:: 号(两个英文冒号)起分隔作用；
;	run，非常常用 的 AHK 命令之一;
;	; 号代表 注释后面一行内容；

; 打开网站
^#g:: run https://www.google.com
^#b:: run https://www.baidu.com
^#l:: run http://www.lua.org/manual/5.3
^#u:: run https://docs.unity3d.com/cn/current/Manual/UnityManual.html

; 打开应用
!r:: run D:\Applications\Scoop\apps\windows-terminal\current\WindowsTerminal.exe
!e:: run D:\Applications\Scoop\apps\everything\current\Everything.exe
!c:: run D:\Applications\Scoop\apps\vscode\current\Code.exe

; 一件拷贝路径
^+c::
; null= 
send ^c
sleep,200
clipboard=%clipboard% ;%null%
tooltip,%clipboard%
sleep,500
tooltip,
return

; 参考
; https://www.jeffjade.com/2016/03/11/2016-03-11-autohotkey/