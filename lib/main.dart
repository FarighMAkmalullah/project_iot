import 'dart:async';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future _futureKoneksi;
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  late Timer _timer1;
  late Timer _timer2;

  late Timer _timer3;
  late Timer _timer4;

  bool _isLampuDisko1Running = false;

  bool _isLampuDisko2Running = false;

  bool _isLampuDisko3Running = false;

  bool _isLampuDisko4Running = false;

  Future hidupkanLampu1() async {
    return await http.get(Uri.parse(
        "https://sgp1.blynk.cloud/external/api/update?token=AM7dOPmL3bwj8JxCK8rf0aboN7HwjkVv&v2=1"));
  }

  Future hidupkanLampu2() async {
    return await http.get(Uri.parse(
        "https://sgp1.blynk.cloud/external/api/update?token=AM7dOPmL3bwj8JxCK8rf0aboN7HwjkVv&v3=1"));
  }

  Future hidupkanColokan1() async {
    return await http.get(Uri.parse(
        "https://sgp1.blynk.cloud/external/api/update?token=AM7dOPmL3bwj8JxCK8rf0aboN7HwjkVv&v0=1"));
  }

  Future hidupkanColokan2() async {
    return await http.get(Uri.parse(
        "https://sgp1.blynk.cloud/external/api/update?token=AM7dOPmL3bwj8JxCK8rf0aboN7HwjkVv&v1=1"));
  }

  Future matikanLampu1() async {
    return await http.get(Uri.parse(
        "https://sgp1.blynk.cloud/external/api/update?token=AM7dOPmL3bwj8JxCK8rf0aboN7HwjkVv&v2=0"));
  }

  Future matikanLampu2() async {
    return await http.get(Uri.parse(
        "https://sgp1.blynk.cloud/external/api/update?token=AM7dOPmL3bwj8JxCK8rf0aboN7HwjkVv&v3=0"));
  }

  Future matikanColokan1() async {
    return await http.get(Uri.parse(
        "https://sgp1.blynk.cloud/external/api/update?token=AM7dOPmL3bwj8JxCK8rf0aboN7HwjkVv&v0=0"));
  }

  Future matikanColokan2() async {
    return await http.get(Uri.parse(
        "https://sgp1.blynk.cloud/external/api/update?token=AM7dOPmL3bwj8JxCK8rf0aboN7HwjkVv&v1=0"));
  }

  void diskoLampu1() {
    if (!_isLampuDisko1Running) {
      _timer1 = Timer.periodic(Duration(milliseconds: 700), (timer) {
        if (lampu1 == 0) {
          hidupkanLampu1();
          setState(() {
            lampu1 = 1;
          });
        } else if (lampu1 == 1) {
          matikanLampu1();
          setState(() {
            lampu1 = 0;
          });
        }
      });
      setState(() {
        _isLampuDisko1Running = true;
      });
    }
  }

  void diskoLampu2() {
    if (!_isLampuDisko2Running) {
      _timer2 = Timer.periodic(Duration(milliseconds: 700), (timer) {
        if (lampu2 == 0) {
          hidupkanLampu2();
          setState(() {
            lampu2 = 1;
          });
        } else if (lampu2 == 1) {
          matikanLampu2();
          setState(() {
            lampu2 = 0;
          });
        }
      });
      setState(() {
        _isLampuDisko2Running = true;
      });
    }
  }

  void diskoKananKiri() {
    if (!_isLampuDisko3Running) {
      _timer3 = Timer.periodic(Duration(milliseconds: 700), (timer) {
        if (lampu1 == 0) {
          hidupkanLampu1();
          matikanLampu2();
          setState(() {
            lampu1 = 1;
            lampu2 = 0;
          });
        } else if (lampu1 == 1) {
          matikanLampu1();
          hidupkanLampu2();
          setState(() {
            lampu1 = 0;
            lampu2 = 1;
          });
        }
      });
      setState(() {
        _isLampuDisko3Running = true;
      });
    }
  }

  void diskoKananKananKiriKiri() {
    if (!_isLampuDisko4Running) {
      _timer4 = Timer.periodic(Duration(milliseconds: 700), (timer) {
        if (lampu2 == 0) {
          hidupkanLampu2();
          hidupkanLampu1();
          setState(() {
            lampu2 = 1;
            lampu1 = 1;
          });
        } else if (lampu2 == 1) {
          matikanLampu2();
          matikanLampu1();
          setState(() {
            lampu2 = 0;
            lampu1 = 0;
          });
        }
      });
      setState(() {
        _isLampuDisko4Running = true;
      });
    }
  }

  void diskoBerhentiLampu1() {
    if (_isLampuDisko1Running) {
      _timer1?.cancel();
      setState(() {
        _isLampuDisko1Running = false;
      });
    }
  }

  void diskoBerhenti4() {
    if (_isLampuDisko4Running) {
      _timer4?.cancel();
      setState(() {
        _isLampuDisko4Running = false;
      });
    }
  }

  void diskoBerhentiLampu2() {
    if (_isLampuDisko2Running) {
      _timer2?.cancel();
      setState(() {
        _isLampuDisko2Running = false;
      });
    }
  }

  void diskoBerhentiKananKiri() {
    if (_isLampuDisko3Running) {
      _timer3?.cancel();
      setState(() {
        _isLampuDisko3Running = false;
      });
    }
  }

  Future matikanSemua() async {
    matikanColokan1();
    matikanColokan2();
    matikanLampu1();
    matikanLampu2();
    diskoBerhentiLampu1();

    diskoBerhentiLampu2();

    diskoBerhentiKananKiri();
    diskoBerhenti4();
  }

  Future hidupkanSemua() async {
    diskoBerhentiLampu1();

    diskoBerhenti4();
    diskoBerhentiLampu2();
    diskoBerhentiKananKiri();
    hidupkanColokan1();
    hidupkanColokan2();
    hidupkanLampu1();
    hidupkanLampu2();
  }

  late String koneksiVar = 'false';

  int colokan1 = 0;
  int colokan2 = 0;
  int lampu1 = 0;
  int lampu2 = 0;

  Future fetchApiKoneksi() async {
    final response = await http.get(Uri.parse(
        "https://sgp1.blynk.cloud/external/api/isHardwareConnected?token=AM7dOPmL3bwj8JxCK8rf0aboN7HwjkVv"));
    if (response.statusCode == 200) {
      setState(() {
        koneksiVar = response.body;
      });
    } else {
      throw Exception('Failed to load Album');
    }
  }

  @override
  void initState() {
    super.initState();
    _futureKoneksi = fetchApiKoneksi();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) async {
    setState(() {
      _lastWords = result.recognizedWords;
    });
    if (result.recognizedWords.toLowerCase() == "hidupkan lampu satu" ||
        result.recognizedWords.toLowerCase() == "hidupkan lampu 1") {
      diskoBerhentiKananKiri();
      diskoBerhentiLampu1();
      hidupkanLampu1();

      diskoBerhenti4();
      setState(() {
        lampu1 = 1;
      });
    } else if (result.recognizedWords.toLowerCase() == "matikan lampu 1" ||
        result.recognizedWords.toLowerCase() == "matikan lampu satu") {
      diskoBerhentiLampu1();
      diskoBerhentiKananKiri();
      matikanLampu1();

      diskoBerhenti4();
      setState(() {
        lampu1 = 0;
      });
    } else if (result.recognizedWords.toLowerCase() == "hidupkan lampu 2" ||
        result.recognizedWords.toLowerCase() == "hidupkan lampu dua") {
      diskoBerhentiLampu2();
      diskoBerhentiKananKiri();
      hidupkanLampu2();
      diskoBerhenti4();
      setState(() {
        lampu2 = 1;
      });
    } else if (result.recognizedWords.toLowerCase() == "matikan lampu 2" ||
        result.recognizedWords == "matikan lampu dua") {
      diskoBerhentiLampu2();
      matikanLampu2();

      diskoBerhenti4();
      diskoBerhentiKananKiri();
      setState(() {
        lampu2 = 0;
      });
    } else if (result.recognizedWords.toLowerCase() == "hidupkan colokan 1" ||
        result.recognizedWords.toLowerCase() == "hidupkan colokan satu") {
      hidupkanColokan1();
      setState(() {
        colokan1 = 1;
      });
    } else if (result.recognizedWords.toLowerCase() == "matikan colokan 1" ||
        result.recognizedWords.toLowerCase() == "matikan colokan satu") {
      matikanColokan1();
      setState(() {
        colokan1 = 0;
      });
    } else if (result.recognizedWords.toLowerCase() == "hidupkan colokan 2" ||
        result.recognizedWords.toLowerCase() == "hidupkan colokan dua") {
      hidupkanColokan2();
      setState(() {
        colokan2 = 1;
      });
    } else if (result.recognizedWords.toLowerCase() == "matikan colokan 2" ||
        result.recognizedWords.toLowerCase() == "matikan colokan dua") {
      matikanLampu2();
      setState(() {
        colokan2 = 0;
      });
    } else if (result.recognizedWords.toLowerCase() == "matikan semua") {
      matikanSemua();
      setState(() {
        lampu1 = 0;
        colokan1 = 0;
        colokan2 = 0;
        lampu2 = 0;
      });
    } else if (result.recognizedWords.toLowerCase() == "hidupkan semua") {
      hidupkanSemua();
      setState(() {
        lampu1 = 1;
        colokan1 = 1;
        colokan2 = 1;
        lampu2 = 1;
      });
    } else if (result.recognizedWords.toLowerCase() == "kelap-kelip lampu 1" ||
        result.recognizedWords.toLowerCase() == "kelap kelip lampu 1" ||
        result.recognizedWords.toLowerCase() == "kelap-kelip lampu satu" ||
        result.recognizedWords.toLowerCase() == "kelap kelip lampu satu") {
      diskoBerhentiLampu2();
      diskoBerhenti4();
      diskoBerhentiKananKiri();
      diskoLampu1();
    } else if (result.recognizedWords.toLowerCase() == "kelap-kelip lampu 2" ||
        result.recognizedWords.toLowerCase() == "kelap kelip lampu 2" ||
        result.recognizedWords.toLowerCase() == "kelap-kelip lampu dua" ||
        result.recognizedWords.toLowerCase() == "kelap kelip lampu dua") {
      diskoBerhentiLampu1();
      diskoBerhenti4();
      diskoBerhentiKananKiri();
      diskoLampu2();
    } else if (result.recognizedWords.toLowerCase() ==
            "kelap-kelip kanan kiri" ||
        result.recognizedWords.toLowerCase() == "kelap kelip kanan kiri") {
      diskoBerhentiLampu1();
      diskoBerhenti4();
      diskoBerhentiLampu2();
      diskoKananKiri();
    } else if (result.recognizedWords.toLowerCase() ==
            "kelap-kelip bersamaan" ||
        result.recognizedWords.toLowerCase() == "kelap kelip bersamaan") {
      diskoBerhentiLampu1();
      diskoBerhentiKananKiri();
      diskoBerhentiLampu2();
      diskoKananKananKiriKiri();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project IOT Kelompok 2'),
      ),
      body: FutureBuilder(
          future: _futureKoneksi,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const CircularProgressIndicator();
            } else if (koneksiVar.isNotEmpty) {
              return koneksiVar == 'true'
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: colokan1 == 0
                                        ? Colors.black
                                        : Colors.blue,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: lampu1 == 0
                                        ? Colors.black
                                        : Colors.blue,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: lampu2 == 0
                                        ? Colors.black
                                        : Colors.blue,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: colokan2 == 0
                                        ? Colors.black
                                        : Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                FractionallySizedBox(
                                  widthFactor: 1.0,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: colokan1 == 0
                                          ? Colors.blueGrey[50]
                                          : Colors.blue,
                                    ),
                                    onPressed: () {
                                      if (colokan1 == 0) {
                                        hidupkanColokan1();
                                        setState(() {
                                          colokan1 = 1;
                                        });
                                      } else {
                                        matikanColokan1();
                                        setState(() {
                                          colokan1 = 0;
                                        });
                                      }
                                    },
                                    child: Text(
                                      'Colokan 1',
                                      style: TextStyle(
                                        color: colokan1 == 1
                                            ? Colors.purple[50]
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                FractionallySizedBox(
                                  widthFactor: 1.0,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: lampu1 == 0
                                          ? Colors.blueGrey[50]
                                          : Colors.blue,
                                    ),
                                    onPressed: () {
                                      if (lampu1 == 0) {
                                        hidupkanLampu1();
                                        setState(() {
                                          lampu1 = 1;
                                        });
                                      } else {
                                        matikanLampu1();
                                        setState(() {
                                          lampu1 = 0;
                                        });
                                      }
                                    },
                                    child: Text(
                                      'Lampu 1',
                                      style: TextStyle(
                                        color: lampu1 == 1
                                            ? Colors.purple[50]
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                FractionallySizedBox(
                                  widthFactor: 1.0,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: lampu2 == 0
                                            ? Colors.blueGrey[50]
                                            : Colors.blue,
                                      ),
                                      onPressed: () {
                                        if (lampu2 == 0) {
                                          hidupkanLampu2();
                                          setState(() {
                                            lampu2 = 1;
                                          });
                                        } else {
                                          matikanLampu2();
                                          setState(() {
                                            lampu2 = 0;
                                          });
                                        }
                                      },
                                      child: Text(
                                        'Lampu 2',
                                        style: TextStyle(
                                          color: lampu2 == 1
                                              ? Colors.purple[50]
                                              : Colors.black,
                                        ),
                                      )),
                                ),
                                FractionallySizedBox(
                                  widthFactor: 1.0,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: colokan2 == 0
                                            ? Colors.blueGrey[50]
                                            : Colors.blue,
                                      ),
                                      onPressed: () {
                                        if (colokan2 == 0) {
                                          hidupkanColokan2();
                                          setState(() {
                                            colokan2 = 1;
                                          });
                                        } else {
                                          matikanColokan2();
                                          setState(
                                            () {
                                              colokan2 = 0;
                                            },
                                          );
                                        }
                                      },
                                      child: Text(
                                        'Colokan 2',
                                        style: TextStyle(
                                          color: colokan2 == 1
                                              ? Colors.purple[50]
                                              : Colors.black,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(16),
                            child: const Text(
                              'Recognized words:',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Text(_lastWords),
                                  Text(
                                    _speechToText.isListening
                                        ? _lastWords
                                        : _speechEnabled
                                            ? 'Tap the microphone to start listening...'
                                            : 'Speech not available',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Controller tidak tersambung internet"),
                          ElevatedButton(
                              onPressed: () {
                                _futureKoneksi = fetchApiKoneksi();
                              },
                              child: Text('Reload'))
                        ],
                      ),
                    );
            } else {
              return Container(
                child: const Text('data'),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed:
            _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
    );
  }
}
