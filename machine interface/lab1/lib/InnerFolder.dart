import 'dart:io';

import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class InnerFolder extends StatefulWidget {
  InnerFolder({required this.filespath});
  final String filespath;

  @override
  State<StatefulWidget> createState() {
    return InnerFolderState();
  }
}

class InnerFolderState extends State<InnerFolder> {
  String get fileStr => widget.filespath;
  Future<String> createFolderInAppDocDir(String folderName) async {
    //Get this App Document Directory

    final Directory _appDocDir = await getApplicationDocumentsDirectory();
    //App Document Directory + folder name
    final Directory _appDocDirFolder =
        Directory('${_appDocDir.path}/$folderName/');

    if (await _appDocDirFolder.exists()) {
      //if folder already exists return path
      return _appDocDirFolder.path;
    } else {
      //if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder =
          await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder.path;
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
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
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
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Text(
                'No',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  late List<FileSystemEntity> _folders;
  Future<void> getDir() async {
    final myDir = Directory(fileStr);
    var _folders_list = myDir.listSync(recursive: true, followLinks: false);
    setState(() {
      _folders = myDir.listSync(recursive: true, followLinks: false);
    });
    print(_folders);
  }

  Future<void> _showDeleteDialog(int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Are you sure to delete this folder?',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                await _folders[index].delete();
                getDir();
                Navigator.of(context).pop();
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
    _folders = [];
    getDir();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 25,
        ),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
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
                              FileStat f = snapshot.data as FileStat;
                              print("file.stat() ${f.type}");

                              if (f.type.toString().contains("file")) {
                                return Icon(
                                  Icons.file_copy_outlined,
                                  size: 100,
                                  color: Colors.orange,
                                );
                              }
                            }
                            return const Icon(
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
                                _folders[index].path.split('/').last,
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
    final directory = fileSystem.directory(fileStr);
    directory.list(recursive: true).listen((file) async {
      File fileCurr = File(file.path);
      if (file.path.split("/").last.split('.').first ==
          filePath.split('.').first) {
        if (await fileCurr.exists()) {
          String newFilePath = (fileStr + "/" + filePath)
              .replaceAll(RegExp(r'\.\w+$'), '.$newExtension');
          print(newFilePath);
          await fileCurr.rename(newFilePath);
          setState(() {
            // result = 'File extension changed to .$newExtension';
          });
        } else {
          setState(() {
            // result = 'File not found';
          });
        }
      }
    });
  }
}
