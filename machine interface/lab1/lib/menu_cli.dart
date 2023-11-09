import 'dart:async';
import 'dart:io';

import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:path_provider/path_provider.dart';

import 'InnerFolder.dart';

class MenuCLI extends StatefulWidget {
  const MenuCLI({super.key});

  @override
  State<MenuCLI> createState() => _MenuCLIState();
}

class _MenuCLIState extends State<MenuCLI> {
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
    currPath = dir;
    String pdfDirectory = '$dir/';
    final myDir = Directory(pdfDirectory);
    setState(() {
      final folders = myDir.listSync(recursive: true, followLinks: false);
      _files = folders;
      _folders = folders
          .where((element) => element.path.split('/').last.contains("."))
          .toList();
    });
    print(_files);
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
    _files = [];
    getDir();
    super.initState();
  }

  String commandInpot = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lab2")),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(currPath),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          !(commandInpot == "show")
                              ? Colors.blue
                              : Colors.green)),
                  onPressed: () {
                    getDir();
                    setState(() {
                      commandInpot = "show";
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Text('Show'),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            !(commandInpot == "show --file")
                                ? Colors.blue
                                : Colors.green)),
                    onPressed: () {
                      setState(() {
                        commandInpot = "show --file";
                      });
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Text('Show --file'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            !(commandInpot == "edittype")
                                ? Colors.blue
                                : Colors.green)),
                    onPressed: () {
                      setState(() {
                        commandInpot = "edittype";
                      });
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Text('Edit Type'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            !(commandInpot == "help")
                                ? Colors.blue
                                : Colors.green)),
                    onPressed: () {
                      setState(() {
                        commandInpot = "help";
                      });
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Text('Help'),
                    ),
                  ),
                ),
              ],
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
                                                      MaterialPageRoute(
                                                          builder: (builder) {
                                                    return InnerFolder(
                                                        filespath:
                                                            _files[index].path);
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
                  } else if (args.length == 2 && args[1] == "help") {
                    print(' Implement \'show help\'');
                    // Implement 'show help'
                  } else {
                    print(
                        "Invalid 'show' command. Type 'help' for documentation.");
                  }
                } else if (command == "edittype") {
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
                                          }
                                        }
                                        return Icon(
                                          Icons.file_copy_outlined,
                                          size: 100,
                                          color: Colors.orange,
                                        );
                                      }),
                                  TextFormField(
                                    initialValue:
                                        ' ${_folders[index].path.split('/').last}',
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    onFieldSubmitted: (val) {
                                      print("object");
                                      setState(() {
                                        changeFileExtension(
                                            _folders[index]
                                                .path
                                                .split('/')
                                                .last,
                                            val.split('.').last);
                                      });
                                    },
                                  )
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
                } else if (command == "cd") {
                  if (args.length == 2) {
                    return Text(
                      currPathCd,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    );
                  } else if (args.length == 1) {
                    print(" Implement 'cd' to show the current directory");
                    return Text(
                      currPath,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    );
                  } else {
                    print(
                        "Invalid 'cd' command. Type 'help' for documentation.");
                  }
                } else {
                  print("Invalid command. Type 'help' for documentation.");
                }
                return SizedBox();
              }),
            ),
          ],
        ),
      ),
    );
  }

  Future getFileType(file) {
    return file.stat();
  }

  Future<void> changeFileExtension(String filePath, String newExtension) async {
    const fileSystem = LocalFileSystem();
    print(filePath);
    print(newExtension);
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
