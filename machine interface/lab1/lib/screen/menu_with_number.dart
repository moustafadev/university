import 'dart:async';
import 'dart:io';

import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:lab1/string.dart';
import 'package:path_provider/path_provider.dart';

import '../InnerFolder.dart';

class MenuWithNumber extends StatefulWidget {
  const MenuWithNumber({super.key});

  @override
  State<MenuWithNumber> createState() => _MenuWithNumberState();
}

class _MenuWithNumberState extends State<MenuWithNumber> {
  String currPath = '';
  String result = '';
  String resultEditType = '';
  String currPathCd = '';

  Future<String> createFolderInAppDocDir(String folderName) async {
    final Directory _appDocDir = await getApplicationDocumentsDirectory();
    final Directory _appDocDirFolder =
        Directory('${_appDocDir.path}/$folderName/');

    if (await _appDocDirFolder.exists()) {
      return _appDocDirFolder.path;
    } else {
      final Directory _appDocDirNewFolder =
          await _appDocDirFolder.create(recursive: true);
      return _appDocDirFolder.path;
    }
  }

  callFolderCreationMethod(String folderInAppDocDir) async {
    // ignore: unused_local_variable
    String actualFileName = await createFolderInAppDocDir(folderInAppDocDir);
    print(actualFileName);
    setState(() {});
  }

  final folderController = TextEditingController();
  final cdChoose = TextEditingController();
  final editChoose = TextEditingController();
  late String nameOfFolder;

  late List<FileSystemEntity> _files;
  late List<FileSystemEntity> _folders;
  late List<FileSystemEntity> _foldersFile;

  Future<void> getDir() async {
    final directory = await getApplicationDocumentsDirectory();
    final dir = directory.path;
    if (currPath.isEmpty) currPath = dir;
    // currPath = dir;
    String pdfDirectory = '$dir/';
    final myDir = Directory(currPath);
    setState(() {
      final folders = myDir.listSync(recursive: true, followLinks: false);
      _files = folders;
      _folders = folders
          .where((element) => element.path.split('/').last.contains("."))
          .toList();
      _foldersFile = folders
          .where((element) => !element.path.split('/').last.contains("."))
          .toList();
      print('dfdfg');
    });
    // print(_files);
  }

  Future<void> _showDeleteDialog(int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Are you sure to delete this folder?',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                await _files[index].delete();
                getDir().then((value) {
                  Navigator.of(context).pop();
                });
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    _files = [];
    getDir();
    super.initState();
  }

  String commandInpot = "";

  @override
  Widget build(BuildContext context) {
    List<String> fileComCD = commandInpot.split(" ");
    print(result);
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                "1. Вывести всё содержимое текущего каталога\n2. Вывести файлы текущего каталога\n3. Перейти в другой каталог\n4. Изменить тип файла\n5. Изменить тип группы файлов\n6. Справка\n7. Выход",
              ),
            ),
          ),
          Divider(),
          TextFormField(
            controller: folderController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'CLI',
              prefix: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text("~/${currPath.split('/').last}"),
              ),
            ),
            onFieldSubmitted: (val) async {
              setState(() {
                commandInpot = val;
                cdChoose.clear();
                editChoose.clear();
              });
              print("currPath$currPath");
              List<String> args = commandInpot.split(" ");
              String command = args[0];

              if (command == "1" || command == "2") {
                getDir();
              } else if (command == "7") {
                Navigator.pop(context);
              }
            },
          ),
          if (fileComCD[0] == "3") ...[
            SizedBox(
              height: 150,
              child: GridView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 25,
                ),
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 50,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return Text(
                    '${_foldersFile[index].path.split('/').last}',
                  );
                },
                itemCount: _foldersFile.length,
              ),
            ),
            Text(
              "1. Переход в дочерний каталог относительного данного каталога\n2.Переход в родительский каталог относительного данного каталога",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            TextFormField(
              controller: cdChoose,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'CLI',
                prefix: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text("~/${currPath.split('/').last}"),
                ),
              ),
              onFieldSubmitted: (val) async {
                if (val.contains("2")) {
                  currPathCd = currPath
                      .split("/")
                      .where((element) => element != currPath.split("/").last)
                      .join("/");

                  currPath = currPathCd;
                }
                setState(() {
                  getDir();
                });
              },
            ),
          ],
          if (fileComCD[0] == "4" || fileComCD[0] == "5") ...[
            Text(
              "Для изменения типа введите название файла с расширением через пробел, тип которых хотите изменить (с точкой )",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            TextFormField(
              controller: editChoose,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'CLI',
                prefix: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text("~/${currPath.split('/').last}"),
                ),
              ),
              onFieldSubmitted: (val) async {
                final value = "edittype "+val;
                List<String> args = value.split(" ");

                String command = args[0];
                if (args.length >= 3) {
                  String newExtension = args.sublist(1, args.length).last;
                  List<String> files = args.sublist(1, args.length - 1);
                  if (commandInpot == "5") {
                    files.forEach((e) {
                      changeFileExtension(e, newExtension);
                    });
                  } else {
                    print(value);
                    changeFileExtension(files.first, newExtension);
                  }
                } else {
                  print(
                      "Invalid 'edittype' command. Type 'help' for documentation.");
                }
              },
            ),
          ],
          if (cdChoose.text == "1") ...[
            Text(
              "Введите название каталога, в которую хотите перейти:",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            TextFormField(
              // controller: cdChoose,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'CLI',
                prefix: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text("~/${currPath.split('/').last}"),
                ),
              ),
              onFieldSubmitted: (val) async {
                if (await chackFileExpted(val)) {
                  currPathCd = "$currPath/${val.split(' ').last}";
                  currPath = currPathCd;
                } else {
                  setState(() {
                    print("field error");
                    result = "Invalid 'cd' command. Type 'help' for documentation.";
                  });
                }

                setState(() {
                  getDir();
                });
              },
            ),
          ],
          Expanded(
            child: SingleChildScrollView(
              child: Builder(builder: (context) {
                List<String> args = commandInpot.split(" ");
                String command = args[0];
                if (command == "1") {
                  if (args.length == 1) {
                    return GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 25,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 180,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        return Material(
                          elevation: 6.0,
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FutureBuilder(
                                        future: getFileType(_files[index]),
                                        builder: (ctx, snapshot) {
                                          if (snapshot.hasData) {
                                            FileStat f =
                                                snapshot.data as FileStat;
                                            print("file.stat() ${f.type}");
                                            if (f.type
                                                .toString()
                                                .contains("file")) {
                                              return Icon(
                                                Icons.file_copy_outlined,
                                                size: 100,
                                                color: Colors.orange,
                                              );
                                            } else {
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.push(context,
                                                      new MaterialPageRoute(
                                                          builder: (builder) {
                                                    return InnerFolder(
                                                        filespath:
                                                            _folders[index]
                                                                .path);
                                                  }));
                                                },
                                                child: Icon(
                                                  Icons.folder,
                                                  size: 100,
                                                  color: Colors.orange,
                                                ),
                                              );
                                            }
                                          }
                                          return Icon(
                                            Icons.file_copy_outlined,
                                            size: 100,
                                            color: Colors.orange,
                                          );
                                        }),
                                    Text(
                                      '${_files[index].path.split('/').last}',
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: GestureDetector(
                                  onTap: () {
                                    _showDeleteDialog(index);
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: _files.length,
                    );
                  } else {
                    return const Text(
                      "Invalid 'show' command. Type 'help' for documentation.",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    );
                  }
                } else if (command == "2") {
                  return GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 25,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 180,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return Material(
                        elevation: 6.0,
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FutureBuilder(
                                      future: getFileType(_folders[index]),
                                      builder: (ctx, snapshot) {
                                        if (snapshot.hasData) {
                                          FileStat f =
                                              snapshot.data as FileStat;
                                          print("file.stat() ${f.type}");
                                          if (f.type
                                              .toString()
                                              .contains("file")) {
                                            return Icon(
                                              Icons.file_copy_outlined,
                                              size: 100,
                                              color: Colors.orange,
                                            );
                                          } else {
                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(context,
                                                    new MaterialPageRoute(
                                                        builder: (builder) {
                                                  return InnerFolder(
                                                      filespath:
                                                          _folders[index].path);
                                                }));
                                              },
                                              child: Icon(
                                                Icons.folder,
                                                size: 100,
                                                color: Colors.orange,
                                              ),
                                            );
                                          }
                                        }
                                        return Icon(
                                          Icons.file_copy_outlined,
                                          size: 100,
                                          color: Colors.orange,
                                        );
                                      }),
                                  Text(
                                    '${_folders[index].path.split('/').last}',
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: GestureDetector(
                                onTap: () {
                                  _showDeleteDialog(index);
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: _folders.length,
                  );
                } else if (command == "3") {
                  return Column(
                    children: [
                      Text(result)
                    ],
                  );
                } else if (command == "5" || command == "4") {
                  return Text(resultEditType);

                } else if (command == '6') {
                  return const Text(
                    hlpe,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  );
                }
                return const SizedBox();
              }),
            ),
          ),
        ],
      ),
    );
  }

  Future getFileType(file) {
    return file.stat();
  }

  Future<void> changeFileExtension(String filePath, String newExtension) async {
    const fileSystem = LocalFileSystem();
    final directory = fileSystem.directory(currPath);
    directory.list(recursive: true).listen((file) async {
      File fileCurr = File(file.path);
      if (file.path.split("/").last.split('.').first ==
          filePath.split('.').first) {
        if (await fileCurr.exists()) {
          String newFilePath = (currPath + "/" + filePath)
              .replaceAll(RegExp(r'\.\w+$'), '.$newExtension');
          print(newFilePath);
          await fileCurr.rename(newFilePath);
          setState(() {
            resultEditType = 'File extension changed to .$newExtension';
          });
        } else {
          setState(() {
            resultEditType = 'File not found';
          });
        }
      }
    });
  }

  Future<bool> chackFileExpted(String nameFile) async {
    final fileSystem = LocalFileSystem();
    final directory = fileSystem.directory(currPath);
    bool isExp = false;
    final completer = Completer<void>();
    directory.list(recursive: true).listen((file) {
      if (file.path.split("/").last.split('.').first == nameFile) {
        isExp = true;
        setState(() {
          print("object22222");
          result = "Changed current folder";
        });
        completer.complete();

      }else{
        print("object111");
        completer.complete();
      }
    }).onError((e){
      print("object");
    });
    await completer.future;
    return isExp;
  }
}
