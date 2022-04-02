// ignore_for_file: use_key_in_widget_constructors, avoid_print, unnecessary_null_comparison, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:database_sqlite/helpers/db_helper.dart';
import 'package:database_sqlite/models/item.dart';

class EntryForm extends StatefulWidget {
  final Item _item;
  final bool _isNew;

  EntryForm(this._item, this._isNew);

  @override
  State<EntryForm> createState() => _EntryFormState();
}

class _EntryFormState extends State<EntryForm> {
  late Item item;

  final kodeBarangController = TextEditingController();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final stokController = TextEditingController();

  Future insertData() async {
    var db = DBHelper();
    var item = Item(kodeBarangController.text, nameController.text,
        int.parse(priceController.text), int.parse(stokController.text));
    await db.saveItem(item);
    print('Saved');
  }

  Future updateData() async {
    var db = DBHelper();
    var item = Item(kodeBarangController.text, nameController.text,
        int.parse(priceController.text), int.parse(stokController.text));
    item.setItemId(this.item.id);
    await db.updateItem(item);
  }

  void _saveData() {
    if (widget._isNew) {
      insertData();
    } else {
      updateData();
    }
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    if (widget._item != null) {
      item = widget._item;
      kodeBarangController.text = item.kodeBarang;
      nameController.text = item.name;
      priceController.text = item.price.toString();
      stokController.text = item.stok.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._isNew ? 'Tambah Data Barang' : 'Ubah Data Barang'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: kodeBarangController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Masukkan Kode Barang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Masukkan Nama Barang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Harga Barang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: stokController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Stok Barang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: const Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: _saveData,
                    ),
                  ),
                  Container(
                    width: 5.0,
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: const Text(
                        'Cancel',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
