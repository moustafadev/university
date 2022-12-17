
WScript.Echo(WScript.Arguments.count());
if (WScript.Arguments.count() == 2)
{
	var shell = WScript.CreateObject("WScript.Shell");
    WScript.Echo('command');
	var command = "%COMSPEC% /K help ";
	var args = WScript.Arguments;
	var dosCommand = args(0);
	var path = args(1);
	//var fileName = args(2);

	command = command + dosCommand + ">" + path;
    //console.log(command);

	WScript.Echo(command);
	shell.Run(command,true);

} else if (WScript.Arguments.count() == 1) {	// only command
	var shell = WScript.CreateObject("WScript.Shell");
	var command = WScript.Arguments(0);
	shell.Run("%COMSPEC% /K help " + command);
}
