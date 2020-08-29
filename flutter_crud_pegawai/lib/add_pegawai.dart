import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttercrudpegawai/constant.dart';
import 'package:fluttercrudpegawai/main.dart';
import 'package:http/http.dart' as http;

class AddPegawai extends StatefulWidget {
  @override
  _AddPegawaiState createState() => _AddPegawaiState();
}

class _AddPegawaiState extends State<AddPegawai> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  Future<void> savePegawai() async {
    try {
      final response =
          await http.post(Network().BASE_URL + "addPegawai.php", body: {
        'namaPegawai': _namaController.text,
        'posisiPegawai': _posisiPegawai.text,
        'gajiPegawai': _gajiController.text
      });
      var resJson = jsonDecode(response.body);
      if (resJson['is_success'] == true) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => DataPegawai()),
            (Route<dynamic> route) => false);
      } else {
        showInSnackBar('data gaga diinput');
      }
    } catch (e) {
      showInSnackBar('${e.toString()}');
    }
  }

  TextEditingController _namaController = TextEditingController();
  TextEditingController _posisiPegawai = TextEditingController();
  TextEditingController _gajiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Add Pegawai'),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                    hintText: 'Nama',
                    labelText: 'Nama',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _posisiPegawai,
                decoration: InputDecoration(
                    hintText: 'Posisi',
                    labelText: 'Posisi',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _gajiController,
                decoration: InputDecoration(
                    hintText: 'Gaji',
                    labelText: 'Gaji',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
              ),
              MaterialButton(
                  child: Text('SIMPAN'),
                  onPressed: () {
                    setState(() {
                      savePegawai();
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
