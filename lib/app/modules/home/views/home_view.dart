import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: const Text('Chat Mentor'),
            centerTitle: true,
          ),
          bottomSheet: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(5),
              alignment: Alignment.bottomLeft,
              height: 60,
              // color: Colors.blue,
              child: Row(children: [
                SizedBox(
                    width: 300,
                    child: TextField(
                      enabled: !controller.sendBtnDisabled.value,
                      style: const TextStyle(fontSize: 20),
                      controller: controller.textController,
                      onSubmitted: (v) {
                        controller.sendMessage();
                      },
                    )),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: controller.sendBtnDisabled.value
                      ? null
                      : () {
                          controller.sendMessage();
                        },
                )
              ]),
            ),
          ),
          body: Container(
            padding: EdgeInsets.only(
                // top: MediaQuery.of(context).padding.top,
                bottom: MediaQuery.of(context).padding.bottom),
            child: ListView.builder(
              // padding: const EdgeInsets.only(top: 16, bottom: 60),
              controller: controller.scrollController,
              itemCount: controller.messages.value.length,
              itemBuilder: (context, index) {
                return controller.messages[index];
              },
            ),
          ),
        ));
  }
}
