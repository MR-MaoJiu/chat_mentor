import 'package:chat_mentor/app/modules/home/views/personal_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text(controller.title.value),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    // controller.sendBtnDisabled.value = false;
                    // controller.isFirstOpen.value = true;
                    // controller.messages.value.clear();
                    // controller.title.value = "私教老师";
                    Get.to(() => const PersonalCard());
                  },
                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ))
            ],
          ),
          bottomSheet: Container(
            margin: const EdgeInsets.all(16),
            // color: Colors.blue,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (controller.isFirstOpen.value)
                  Wrap(
                    spacing: 2,
                    children: [
                      RawChip(
                        label: const Text('我是初级阶段'),
                        onPressed: () {
                          controller.textController.text = "我是初级阶段";
                          controller.sendMessage();
                          controller.isFirstOpen.value = false;
                        },
                      ),
                      RawChip(
                        label: const Text('我是中级阶段'),
                        onPressed: () {
                          controller.textController.text = "我是中级阶段";
                          controller.sendMessage();
                          controller.isFirstOpen.value = false;
                        },
                      ),
                      RawChip(
                        label: const Text('我是高级阶段'),
                        onPressed: () {
                          controller.textController.text = "我是高级阶段";
                          controller.sendMessage();
                          controller.isFirstOpen.value = false;
                        },
                      )
                    ],
                  ),
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(16)),
                  child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 8,
                          child: TextField(
                            enabled: !controller.sendBtnDisabled.value,
                            textInputAction: TextInputAction.send,
                            style: const TextStyle(fontSize: 20),
                            controller: controller.textController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "说点什么练习你的英语吧！"),
                            onSubmitted: (v) {
                              controller.sendMessage();
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: Colors.blue,
                          ),
                          onPressed: controller.sendBtnDisabled.value
                              ? null
                              : () {
                                  controller.sendMessage();
                                },
                        )
                      ]),
                )
              ],
            ),
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              padding: EdgeInsets.only(
                  // top: MediaQuery.of(context).padding.top,
                  bottom: MediaQuery.of(context).padding.bottom + 60),
              child: ListView.builder(
                // padding: const EdgeInsets.only(top: 16, bottom: 60),
                controller: controller.scrollController,
                itemCount: controller.messages.value.length,
                itemBuilder: (context, index) {
                  return controller.messages[index];
                },
              ),
            ),
          ),
        ));
  }
}
