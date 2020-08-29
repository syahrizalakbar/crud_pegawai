import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttercrudpegawai/constant.dart';
import 'package:fluttercrudpegawai/edit_pegawai.dart';
import 'package:fluttercrudpegawai/main.dart';
import 'package:http/http.dart' as http;

class DetailPegawai extends StatefulWidget {
  final data;
  DetailPegawai(this.data);
  @override
  _DetailPegawaiState createState() => _DetailPegawaiState();
}

class _DetailPegawaiState extends State<DetailPegawai> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.data['nama']}'),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: ListView(
          children: [
            Card(
              child: Column(
                children: [
                  Text('Nama    : ${widget.data['nama']}'),
                  SizedBox(
                    height: 8,
                  ),
                  Text('Posisi  : ${widget.data['posisi']}'),
                  SizedBox(
                    height: 8,
                  ),
                  Text('Gaji    : ${widget.data['gaji']}')
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditPegawai(widget.data)));
                  },
                  child: Text(
                    'Edit',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    _showKonfirmasi(context);
                  },
                  child: Text(
                    'Hapus',
                    style: TextStyle(color: Colors.green),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showKonfirmasi(context) {
    AlertDialog hapus = AlertDialog(
      title: Text('"Hapus data ${widget.data['nama']}"'),
      actions: [
        FlatButton(
            onPressed: () {
              deletePegawai();
            },
            child: Text('Ya')),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('No'))
      ],
    );
    showDialog(context: context, child: hapus);
  }

  Future<void> deletePegawai() async {
    final response = await http.post(Network().BASE_URL + 'deletePegawai.php',
        body: {"idPegawai": widget.data['id']});
    var resJson = jsonDecode(response.body);
    if (resJson['is_success'] == true) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => DataPegawai()),
          (Route<dynamic> route) => false);
    }
  }
}
