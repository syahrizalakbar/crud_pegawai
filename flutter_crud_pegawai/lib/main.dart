import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttercrudpegawai/add_pegawai.dart';
import 'package:fluttercrudpegawai/constant.dart';
import 'package:fluttercrudpegawai/detail_pegawai.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: DataPegawai(),
    debugShowCheckedModeBanner: false,
  ));
}

class DataPegawai extends StatefulWidget {
  @override
  _DataPegawaiState createState() => _DataPegawaiState();
}

class _DataPegawaiState extends State<DataPegawai> {
  Future<Map<String, dynamic>> getPegawai() async {
    final response = await http.get(Network().BASE_URL + 'getPegawai.php');
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Pegawai'),
      ),
      body: FutureBuilder(
          future: getPegawai(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              return _showPegawai(snapshot.data['data']);
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error ${snapshot.error.toString()}'),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPegawai()));
        },
      ),
    );
  }

  Widget _showPegawai(List data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(data[index]['nama']),
              subtitle: Text(data[index]['posisi']),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DetailPegawai(data[index])));
              },
            ),
          );
        });
  }
}
