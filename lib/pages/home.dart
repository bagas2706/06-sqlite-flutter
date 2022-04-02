// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:database_sqlite/pages/list_item.dart';
import 'package:database_sqlite/pages/entryform.dart';
import 'package:database_sqlite/helpers/db_helper.dart';
import 'package:database_sqlite/models/item.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var db = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => EntryForm(
                  Item('', '', 0, 0),
                  true,
                ),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('Daftar Item - Bagas Prambudi (2031710108)'),
        ),
        body: FutureBuilder(
          future: db.getItem(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }

            var data = snapshot.data;

            return snapshot.hasData
                ? ItemList(data as List<Item>)
                : const Center(
                    child: Text('Tidak Ada Data'),
                  );
          },
        ));
  }
}
