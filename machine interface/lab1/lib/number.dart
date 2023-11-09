import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'checkbox_widget.dart';

class Namber extends StatefulWidget {
  const Namber({super.key});

  @override
  State<Namber> createState() => _PictogramState();
}

class _PictogramState extends State<Namber> {
  bool isShow = false;
  bool isFinished = true;
  List<String> number = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9"
  ];
  List<String> numberRandom = [];

  List<String> selectedNumbers = [];
  List<String> result = [];

  void handleCheckboxSelection() {
    setState(() {//result

      if(selectedNumbers.length == 6){
        final res = selectedNumbers.where((element) => numberRandom.contains(element)).length;
        isFinished = true;
        result.add(res.toString());
      }

    });
  }

  void generateRandomIntegers() {
    Set<int> randomIndices = Set<int>();
    Random random = Random();

    while (randomIndices.length < 6) {
      int index = random.nextInt(number.length);
      randomIndices.add(index);
    }
    numberRandom = randomIndices.map((index) => number[index]).toList();
    selectedNumbers.clear();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isShow = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("арабское число"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          if (isShow)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: numberRandom
                  .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                e,
                style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
              ),
                  ))
                  .toList(),
            ),
          if (!isShow && !isFinished)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                9,
                    (index) => CheckboxWidget(
                  onChanged: () {
                    setState(() {
                      if (selectedNumbers.contains(number[index])) {
                        print("remove");
                        selectedNumbers.remove(number[index]);
                      } else {
                        print("add");
                        selectedNumbers.add(number[index]);
                      }
                    });
                    if(selectedNumbers.length==6)
                      handleCheckboxSelection();
                  },
                  text: (index + 1).toString(),
                ),
              ),
            ),
          SizedBox(
            height: 20,
          ),
          if (!isShow && isFinished)
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (!isShow) generateRandomIntegers();
                    isShow = true;
                    isFinished = false;
                  });
                },
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: Text('Start'),
                ),
              ),
            ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Table(
                border: TableBorder.all(), // Border for the table
                children: [
                  const TableRow(
                    children: [
                      TableCell(child: Center(child: Text('N°'))),
                      TableCell(child: Center(child: Text('результаты'))),
                    ],
                  ),
                  ...result.map(
                        (index) {
                      return TableRow(
                        children: [
                          TableCell(child: Center(child: Text('${result.indexOf(index)+1}'))),
                          TableCell(
                            child: Center(
                              child: Text(
                                index,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
