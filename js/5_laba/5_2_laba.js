var address = WScript.Arguments(0) + '\\';
var name_p = WScript.Arguments(1);
var mode = WScript.Arguments(2);
var shell = WScript.CreateObject("WScript.Shell");

shell.Run("notepad.exe " + address + name_p, 1, true);
if (mode == "cmd")
{
	shell.Run("cmd.exe /K cscript " + address + name_p);
}
else if (mode == "window")
{
	shell.Run("cmd.exe /K wscript " + address + name_p + " & exit");
}
else
{
	WScript.Echo("Choice error");
}
