import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Mentor'),
        centerTitle: true,
      ),
      body: Obx(() => Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.grey.shade100,
                    child: ListView.builder(
                      reverse: true,
                      itemCount: controller.messages.value.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Text(controller.messages.value[index]),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.bottomLeft,
                  height: 60,
                  color: Colors.blue,
                  child: Row(children: [
                    SizedBox(
                        width: 300,
                        child: TextField(
                          style: const TextStyle(fontSize: 20),
                          controller: controller.textController,
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
                // Positioned(
                //   child: Row(children: [Text('23'), Text('444')]),
                //   bottom: 0,
                //   left: 0,
                // )
              ],
            ),
          )),
    );
  }
}
