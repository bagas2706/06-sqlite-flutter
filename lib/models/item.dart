// ignore_for_file: unnecessary_this

class Item {
  late int id;
  late String _kodeBarang;
  late String _name;
  late int _price;
  late int _stok;

  Item(this._kodeBarang, this._name, this._price, this._stok);

  Item.map(dynamic obj) {
    this._kodeBarang = obj['kode_barang'];
    this._name = obj['name'];
    this._price = obj['price'];
    this._stok = obj['stok'];
  }

  String get kodeBarang => _kodeBarang;
  String get name => _name;
  int get price => _price;
  int get stok => _stok;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['kode_barang'] = _kodeBarang;
    map['name'] = _name;
    map['price'] = _price;
    map['stok'] = _stok;
    return map;
  }

  void setItemId(int id) {
    this.id = id;
  }
}
