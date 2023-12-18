import 'dart:async';
import 'dart:io';

import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:lab1/string.dart';
import 'package:path_provider/path_provider.dart';

import 'InnerFolder.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  String currPath = '';
  String result = '';
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
  late String nameOfFolder;
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: const [
              Text(
                'ADD FOLDER',
                textAlign: TextAlign.left,
              ),
              Text(
                'Type a folder name to add',
                style: TextStyle(
                  fontSize: 14,
                ),
              )
            ],
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return TextField(
                controller: folderController,
                autofocus: true,
                decoration: InputDecoration(hintText: 'Enter folder name'),
                onChanged: (val) {
                  setState(() {
                    nameOfFolder = folderController.text;
                    print(nameOfFolder);
                  });
                },
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                if (nameOfFolder != null) {
                  await callFolderCreationMethod(nameOfFolder);
                  getDir();
                  setState(() {
                    folderController.clear();
                    nameOfFolder = "";
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: const Text(
                'No',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  late List<FileSystemEntity> _files;
  late List<FileSystemEntity> _folders;
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
      print('dfdfg$directory');
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Folder Info"),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {
              _showMyDialog();
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              });
              List<String> args = commandInpot.split(" ");
              String command = args[0];

              if (command == "show") {
                getDir();
              } else if (command == "edittype") {
                if (args.length >= 3) {
                  String type = args.last;
                  String newExtension = args.sublist(1, args.length).last;
                  List<String> files = args.sublist(1, args.length - 1);
                  if (args.contains("-g")) {
                    files.forEach((e) {
                      changeFileExtension(e, newExtension);
                    });
                  } else {
                    changeFileExtension(files.first, newExtension);
                  }
                } else {
                  print(
                      "Invalid 'edittype' command. Type 'help' for documentation.");
                }
              } else if (command == "cd") {
                if (val == "cd ..") {
                  currPathCd = currPath
                      .split("/")
                      .where((element) => element != currPath.split("/").last)
                      .join("/");
                  print("currPath$currPathCd");
                  currPath = currPathCd;
                } else {
                  if (await chackFileExpted(val.split(' ').last)) {
                    currPathCd = "$currPath/${val.split(' ').last}";
                    currPath = currPathCd;
                  } else {
                    currPathCd =
                        "Invalid 'cd' command. Type 'help' for documentation.";
                  }
                }

                setState(() {
                  getDir();
                });
              }
            },
          ),
          Expanded(
            child: Builder(builder: (context) {
              List<String> args = commandInpot.split(" ");
              String command = args[0];
              if (command == "show") {
                if (args.length == 1) {
                  return GridView.builder(
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
                } else if (args.length == 2 && args[1] == "--file") {
                  return GridView.builder(
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
                } else {
                  return const Text(
                    "Invalid 'show' command. Type 'help' for documentation.",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  );
                }
              } else if (command == "edittype") {
                if (args.length >= 3) {
                  String type = args.last;
                  List<String> files = args.sublist(1, args.length);
                  return Text(result);
                } else {
                  return const Text(
                    "Invalid 'edittype' command. Type 'help' for documentation.",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  );
                }
              } else if (command == "cd") {
                if (args.length == 2) {
                  return Text(
                    currPathCd,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  );
                } else if (args.length == 1) {
                  return Text(
                    currPath,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  );
                } else {
                  return const Text(
                    "Invalid 'cd' command. Type 'help' for documentation.",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  );
                }
              } else if (command == 'help') {
                return const Text(
                  hlpe,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                );
              }
              return const SizedBox();
            }),
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
            result = 'File extension changed to .$newExtension';
          });
        } else {
          setState(() {
            result = 'File not found';
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
        completer.complete();
      }
    });

    await completer.future;
    return isExp;
  }
}
