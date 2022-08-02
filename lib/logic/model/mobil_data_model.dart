import 'dart:convert';

class MobilDataModel {
  int? id;
  String? nama;
  String? warna;
  int? harga;
  String? lokasi;
  String? km;
  String? tanggal_transaksi;
  bool? status_selected;

  MobilDataModel(
      {this.id,
      this.nama,
      this.warna,
      this.harga,
      this.lokasi,
      this.km,
      this.tanggal_transaksi,
      this.status_selected});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'warna': warna,
      'harga': harga,
      'lokasi': lokasi,
      'km': km,
      'tanggal_transaksi': tanggal_transaksi,
      'status_selected': status_selected,
    };
  }

  factory MobilDataModel.fromMap(Map<String, dynamic> map) {
    return MobilDataModel(
      id: map['id'],
      nama: map['nama'],
      warna: map['warna'],
      harga: map['harga'],
      lokasi: map['lokasi'],
      km: map['km'],
      tanggal_transaksi: map['tanggal_transaksi'],
      status_selected: map['status_selected'],
    );
  }

  String toJson() => json.encode(toMap());
}