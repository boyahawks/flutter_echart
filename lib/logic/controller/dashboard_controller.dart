import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:mobil_bekas/logic/model/mobil_data_model.dart';
import 'package:mobil_bekas/logic/model/mobil_item_model.dart';

class DashboardController extends GetxController {

  var globalKey = GlobalKey();

  var corouselController = CarouselController();
  var statusCari = RxBool(false).obs;
  String? testValue;
  var indexDot = 0.obs;

  var dataGraph = [{ 'name': 'Please wait', 'value': 0 }].obs;
  var valGraph = [].obs;
  List<MobilItemModel> itemNav2 = [
    MobilItemModel(
      name : "SEDAN",
      status : true,
    ),
    MobilItemModel(
      name : "SUV",
      status : false,
    ),
    MobilItemModel(
      name : "MPV",
      status : false,
    )
  ];

  var selectedMobil = <MobilDataModel>[].obs;

  List<MobilDataModel> mobil = [
    MobilDataModel(
      id: 1,
      nama: "Toyota Innova 2.5V AT tahun 2015",
      warna : "Hitam",
      harga : 500,
      lokasi : "Surabaya",
      km : "1250",
      tanggal_transaksi : "31/1/2015",
      status_selected: true,
    ),
    MobilDataModel(
      id: 2,
      nama: "Toyota Camry 2.5V AT tahun 2015",
      warna : "Putih",
      harga : 400,
      lokasi : "DKI Jakarta",
      km : "12300",
      tanggal_transaksi : "30/11/2016",
      status_selected: false,
    ),
    MobilDataModel(
      id: 3,
      nama: "Toyota Wuling 2.5V AT tahun 2015",
      warna : "Silver",
      harga : 600,
      lokasi : "DKI Jakarta",
      km : "26520",
      tanggal_transaksi : "2/2/2017",
      status_selected: false,
    ),
    MobilDataModel(
      id: 4,
      nama: "Toyota Rocky 2.5V AT tahun 2015",
      warna : "Putih",
      harga : 300,
      lokasi : "Bandung",
      km : "26520",
      tanggal_transaksi : "20/4/2017",
      status_selected: false,
    ),
    MobilDataModel(
      id: 5,
      nama: "Toyota Raize 2.5V AT tahun 2015",
      warna : "Abu-Abu",
      harga : 200,
      lokasi : "DKI Jakarta",
      km : "41513",
      tanggal_transaksi : "3/3/2018",
      status_selected: false,
    ),
  ];

  void changeStatusCari(value) {
    if (!value) {
      statusCari.value = true.obs;
    }else{
      statusCari.value = false.obs;
    }
  }

  void getSelectedMobil(){
    selectedMobil.clear();
    selectedMobil.addAll(mobil.where((element) => (element.status_selected ?? false) == true).toList());
  }

  void getData1() async{
    await Future.delayed(const Duration(seconds: 4));
    List<Map<String, Object>> convert = [];
    for (var element in mobil) {
      convert.add({
        'name': '${element.tanggal_transaksi}',
        'value': element.harga ?? 0
      });
    }
    dataGraph.value = convert;
  }

  void dialogDetil(value) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            color: const Color.fromARGB(255, 250, 249, 249),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10,),
                const Text("Detail Mobil"),
                Text(testValue ?? ''),
                const SizedBox(height: 15,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(flex: 30,
                      child: const Text("Nama Mobil"),
                    ),
                    Expanded(flex: 70,
                      child: Text(value[0]['nama']),
                    )
                  ],
                ),
                const SizedBox(height: 8,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(flex: 30,
                      child: Text("Warna"),
                    ),
                    Expanded(flex: 70,
                      child: Text(value[0]['warna']),
                    )
                  ],
                ),
                const SizedBox(height: 8,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(flex: 30,
                      child: const Text("KM"),
                    ),
                    Expanded(flex: 70,
                      child: Text(value[0]['km']),
                    )
                  ],
                ),
                const SizedBox(height: 8,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(flex: 30,
                      child: Text("Harga"),
                    ),
                    Expanded(flex: 70,
                      child: Text("Rp${value[0]['harga']} Juta"),
                    )
                  ],
                ),
                const SizedBox(height: 8,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(flex: 30,
                      child: const Text("Lokasi"),
                    ),
                    Expanded(flex: 70,
                      child: Text(value[0]['lokasi']),
                    )
                  ],
                ),
                const SizedBox(height: 8,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(flex: 30,
                      child: Text("Tanggal"),
                    ),
                    Expanded(flex: 70,
                      child: Text(value[0]['tanggal_transaksi']),
                    )
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Tutup"),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  void onMessageReceive(String message, BuildContext context) {
    Map<String, dynamic> messageAction = jsonDecode(message);
    onSetCarouselIndex(messageAction['payload'], context);
    print('Data Message: $messageAction');
  }

  void onSetCarouselIndex(int index, BuildContext context) {
    indexDot.value = index;
    corouselController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.linear);
    final result = HitTestResult();
    WidgetsBinding.instance.hitTest(result, Offset(77.8, 78.3));
    result.path.forEach((element) {

      element.target.handleEvent(
        PointerDownEvent(
            position : Offset(77.8, 78.3),
            kind: PointerDeviceKind.touch),
        element,
      );
      element.target.handleEvent(
        PointerUpEvent(
            position : Offset(77.8, 78.3),
            kind: PointerDeviceKind.touch),
        element,
      );
    });

    // final renderObj = context.findRenderObject();
    // if (renderObj is RenderBox) {
    //   final hitTestResult = BoxHitTestResult();
    //   if (renderObj.hitTest(hitTestResult, position: Offset(78.53826349431819, 76.52414772727275))) {
    //     print('Result: ${hitTestResult.path}');
    //   }
    // }
    // RenderBox box = globalKey.currentContext?.findRenderObject() as RenderBox;
    // Offset position = box.localToGlobal(Offset.zero);
    // final hitTestResult = BoxHitTestResult();
    // box.hitTest(hitTestResult, position: position);
  }

  void onTapItemCarousel(int index) {
    List<MobilDataModel> getRow = mobil.where((element) => element.id == mobil[index].id).toList();
    dialogDetil(getRow);
  }

}
