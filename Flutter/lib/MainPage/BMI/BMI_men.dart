import 'package:flutter/material.dart';
import 'package:flutter_auth/MainPage/Bottom_navbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BMImen extends StatefulWidget {
  var txt;
  BMImen({Key mykey, this.txt}) : super(key: mykey);
  @override
  _BMImenState createState() => _BMImenState();
}

class _BMImenState extends State<BMImen> {
  final formKey = GlobalKey<FormState>();
  double activation = 0;
  int currentindex = 0;
  String result = '';
  double height = 0;
  double weight = 0;
  int age = 0;
  final _valuelist = [
    '주로 좌식 생활',
    '주 1~3일 운동',
    '주 3~5일 운동',
    '거의 매일 운동',
    '매일 강도높게 운동'
  ];
  String dropdownValue = '주로 좌식 생활';
  String holder = '';
  TextEditingController _heightcontroller = TextEditingController();
  TextEditingController _weightcontroller = TextEditingController();
  TextEditingController _agecontroller = TextEditingController();
  String address = 'https://5ffd-119-192-202-235.ngrok.io/signup';

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitDown,
    //   DeviceOrientation.portraitUp,
    // ]);
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          'BMI Calculator',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: Colors.blueAccent[100],
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => BottomNavigator()));
            },
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: this.formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row(
                //   children: [
                //     radioButton('Man', Colors.blueAccent, 0),
                //     radioButton('Woman', Colors.redAccent, 1)
                //   ],
                // ),
                Text('성별선택 : 남자'),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  '나이를 입력하세요 :',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: '나이를 입력하세요',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  controller: _agecontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '나이를 입력해주세요';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  '신장을 입력하세요(cm) :',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: '신장를 입력하세요(cm)',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  controller: _heightcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '신장를 입력해주세요';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  '체중을 입력하세요(Kg) :',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: '체중를 입력하세요(kg)',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  controller: _weightcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '체중를 입력해주세요';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '활동 정도를 선택하세요',
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                      DropdownButton(
                        value: dropdownValue,
                        onChanged: (String newValue) {
                          getDropDownItem();
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: _valuelist
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        elevation: 4,
                        icon: const Icon(Icons.arrow_drop_down_rounded),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    '${widget.txt}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                    width: double.infinity,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          setState(() {
                            age = int.parse(_agecontroller.value.text);
                            height = double.parse(_heightcontroller.value.text);
                            weight = double.parse(_weightcontroller.value.text);
                          });
                          calculateBmi(age, height, weight);
                          sendMenInfo([
                            _agecontroller.value.text,
                            _heightcontroller.value.text,
                            _weightcontroller.value.text,
                            dropdownValue
                          ]);

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BottomNavigator()));
                        }
                      },
                      style: TextButton.styleFrom(primary: Colors.blue[200]),
                      child: Text(
                        'Calculate',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Future<http.Response> sendMenInfo(List title) {
    return http.post(
      Uri.parse(address),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'UUID': widget.txt[0],
        'UPW': widget.txt[1],
        'USEX': '남',
        'UAGE': title[0],
        'UHEIGHT': title[1],
        'UWEIGHT': title[2],
        'UACT': title[3],
        'URDC': result
      }),
    );
  }

  void calculateBmi(int age, double height, double weight) {
    if (dropdownValue == '주로 좌식 생활') {
      activation = 1.2;
    } else if (dropdownValue == '주 1~3일 운동') {
      activation = 1.3;
    } else if (dropdownValue == '주 3~5일 운동') {
      activation = 1.5;
    } else if (dropdownValue == '거의 매일 운동') {
      activation = 1.7;
    } else {
      activation = 1.9;
    }
    double finalresult =
        (66 + (13.7 * weight) + (5 * height) - (6.5 * age)) * activation;
    String bmi = finalresult.toStringAsFixed(0);
    setState(() {
      result = bmi;
    });
  }

  void change(int index) {
    setState(() {
      currentindex = index;
    });
  }

  void getDropDownItem() {
    setState(() {
      holder = dropdownValue;
    });
  }
}
