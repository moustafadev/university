var source_dir_path = WScript.Arguments(0);
var source_file_name = WScript.Arguments(1);
var destination_dir_path = WScript.Arguments(2);
var resultant_file = WScript.Arguments(3);
var shell = WScript.CreateObject("WScript.Shell");
shell.Run("%COMSPEC% /C MKDIR " + source_dir_path); 
var word = WScript.CreateObject("Scripting.FileSystemObject");
var word_path = word.Path;
var sdoc = word.Documents.Add();
word.Selection.TypeText("5th laboratory work OS");
word.ActiveDocument.SaveAs(source_dir_path + '\\' + source_file_name);
sdoc.Close();
word.Quit();
shell.Run("%COMSPEC% /C MKDIR " + destination_dir_path);

shell.Run("%COMSPEC% /C COPY " + source_dir_path + '\\' + source_file_name +
' ' + destination_dir_path + '\\' + source_file_name);

shell.Run("%COMSPEC% /C CD " + "/d " + word_path);
shell.Run("winword.exe  " + destination_dir_path + '\\' + source_file_name, 1,
true);

var sword = WScript.CreateObject("Word.Application");
var source_doc = sword.Documents.Open(source_dir_path + '\\' +
source_file_name);
var secho = "Source file: " + source_doc.Range().Text;
WScript.Echo(secho);
sword.ActiveDocument.Save();
sword.Quit();
var dword = WScript.CreateObject("Word.Application");
var destination_doc = dword.Documents.Open(destination_dir_path + '\\' +
source_file_name);
var decho = "Destination file: " + destination_doc.Range().Text;
WScript.Echo(decho);
dword.ActiveDocument.Save();
dword.Quit();
var recho = secho + " " + decho;
shell.Run("%COMSPEC% /C echo " + recho + " > " + destination_dir_path + '\\'
+ resultant_file);