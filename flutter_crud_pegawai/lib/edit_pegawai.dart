import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttercrudpegawai/constant.dart';
import 'package:fluttercrudpegawai/main.dart';
import 'package:http/http.dart' as http;

class EditPegawai extends StatefulWidget {
  final data;
  EditPegawai(this.data);
  @override
  _EditPegawaiState createState() => _EditPegawaiState();
}

class _EditPegawaiState extends State<EditPegawai> {
  TextEditingController nama, posisi, gaji;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nama = TextEditingController(text: widget.data['nama']);
    posisi = TextEditingController(text: widget.data['posisi']);
    gaji = TextEditingController(text: widget.data['gaji']);
  }

  Future<void> editPegawai() async {
    final response =
        await http.post(Network().BASE_URL + 'editPegawai.php', body: {
      "idPegawai": widget.data['id'],
      "namaPegawai": nama.text,
      "posisiPegawai": posisi.text,
      "gajiPegawai": gaji.text
    });
    var resJson = jsonDecode(response.body);
    if (resJson['is_success'] == true) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => DataPegawai()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.data['nama']}'),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Form(
            child: Column(
          children: [
            TextFormField(
              controller: nama,
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: posisi,
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: gaji,
            ),
            MaterialButton(
              child: Text('Update'),
              onPressed: () {
                editPegawai();
              },
            )
          ],
        )),
      ),
    );
  }
}
