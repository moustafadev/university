// wshExec.js – запуск процесса и ожидание его завершения
var of;
var shell=WScript.CreateObject("WScript.Shell");
WScript.Echo("I am waiting until you close this");
shell.Run(shell.ExpandEnvironmentStrings("%windir%\\notepad.exe"),1,true);