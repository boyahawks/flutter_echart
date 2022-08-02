import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:mobil_bekas/logic/controller/dashboard_controller.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  State<Dashboard> createState() => _DashboardinState();
}

class _DashboardinState extends State<Dashboard> {
  _DashboardinState createState() => _DashboardinState();

  final controller = Get.put(DashboardController());


  @override
  void initState() {
    controller.getSelectedMobil();
    controller.getData1();
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
            child: Column(
              children: [
                navbar(),
                navbar2(),
                informasi(),
                const SizedBox(height:10),
                corousel(),
                // SizedBox(height:10),
                // Corousel2(),
              ],
            ),
        ),
      )),
    );
  }

  Widget navbar() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Obx(() => Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex : 20,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(top: 15),
                    child: const Text("Djubli", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                  ),
                ),
                Expanded(
                    flex : 80,
                  child: controller.statusCari.value == false ?
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(onPressed: () {
                      controller.changeStatusCari(controller.statusCari.value);
                    }, icon: const Icon(Icons.search), iconSize : 30)
                  ) :
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      children : [
                        const Expanded(
                          flex: 90,
                          child: TextField(
                              keyboardType : TextInputType.text,
                            decoration : InputDecoration(
                                hintText : "Search",
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.search),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: IconButton(onPressed: () {
                            controller.changeStatusCari(controller.statusCari.value);
                          }, icon: const Icon(Icons.close), iconSize : 20),
                        ),

                      ]
                    ),
                  )
                )
              ],
            ),
            const Divider(height: 5, color: Colors.black,)
          ],
        ),
      ),
    );
  }

  Widget navbar2() {
    return SizedBox(
      height: 80,
      child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: controller.itemNav2.length, itemBuilder: (context, item){
        return Container(
            margin: const EdgeInsets.all(10),
            width: 110,
            color: Colors.white,
            child: Center(
                child: Text(controller.itemNav2[item].name ?? '',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      decoration: (controller.itemNav2[item].status ?? false) ? TextDecoration.underline : TextDecoration.none),
                )
            )
        );
      }),
    );
  }

  Widget informasi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Center(
            child: Text(controller.selectedMobil.isNotEmpty ? ("${controller.selectedMobil[0].nama} - ${controller.selectedMobil[0].warna} - KM ${controller.selectedMobil[0].km}") : '',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)
            ),
          ),
        ),
        const SizedBox(height: 10,),
        Listener(
          onPointerDown: (event) {
            print('X: ${event.localPosition.dx}');
            print('Y: ${event.localPosition.dy}');
          },
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            height: 250,
            child: Echarts(
              key: controller.globalKey,
              option: '''
              {
                color: ['#228B22'],
                grid: {
                  left: '10%',
                  right: 50,
                  top: '18%',
                  bottom: '10%'
                },
                dataset: {
                  dimensions: ['name', 'value'],
                  source: ${jsonEncode(controller.dataGraph)},
                },
                legend: {
                  show: true,
                },
                tooltip: {
                  trigger: 'axis',
                },
                xAxis: [{
                  type: 'category',
                  name: 'Waktu',
                }],
                yAxis: {
                  type: 'value',
                  name: 'Harga',
                },
                visualMap: [
                  {
                    left: 'right',
                    top: '10%',
                    inRange: {
                      symbolSize: [10, 30]
                    },
                    controller: {
                      inRange: {
                        color: ['#228B22']
                      },
                      outOfRange: {
                        color: ['#228B22']
                      }
                    }
                  }
                ],
                series: [{
                  type: 'scatter'
                }]
                }
              ''',
              extraScript: '''
                 chart.on('click', (params) => {
                    if (params.componentType === 'series') {
                      Messager.postMessage(JSON.stringify({
                        type: 'select',
                        payload: params.dataIndex,
                      }));
                    }
                  });
              ''',
              onMessage: (String message) => controller.onMessageReceive(message, context),
            ),
          ),
        )
      ],
    );
  }

  Widget corousel() {
    return Container(
      margin: const EdgeInsets.only(left: 10 ,right: 10),
      child: Column(
        children: [
          CarouselSlider.builder(
              carouselController: controller.corouselController,
              itemCount: controller.mobil.length,
              itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                InkWell(
                  onTap: () => controller.onTapItemCarousel(itemIndex),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green.shade400,
                      borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10,),
                          Text("${controller.mobil[itemIndex].nama}"),
                          const SizedBox(height: 8,),
                          Text("${controller.mobil[itemIndex].tanggal_transaksi}"),
                          const SizedBox(height: 8,),
                        ],
                      ),
                    ),
                  ),
                ),
              options: CarouselOptions(
                height: 200,
                aspectRatio: 16/2,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: false,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                disableCenter: false,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  controller.indexDot.value = index;
                }
              ),
          ),
          const SizedBox(height: 8,),
          SizedBox(
            child: AnimatedSmoothIndicator(
                activeIndex: controller.indexDot.value,
                count: controller.mobil.length,
                effect: WormEffect(
                  dotHeight: 16,
                  dotWidth: 16,
                  activeDotColor : Colors.green.shade400,
                  type: WormType.thin,
                  // strokeWidth: 5,
                ),
                onDotClicked : (index) => controller.onSetCarouselIndex(index, context)
            ),
          )
        ],
      )
    );
  }


}