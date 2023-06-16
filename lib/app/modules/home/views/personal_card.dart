import 'package:flutter/material.dart';
// import 'package:flutter_cool_card_swiper/constants.dart';
// import 'package:flutter_cool_card_swiper/data.dart';
// import 'package:flutter_cool_card_swiper/widgets/cool_swiper.dart';
import 'package:get/get.dart';
import 'package:swiping_card_deck/swiping_card_deck.dart';

import '../controllers/home_controller.dart';

class PersonalCard extends GetView<HomeController> {
  const PersonalCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Align(
      alignment: Alignment.topCenter,
      child: SwipingCardDeck(
        cardDeck: List.generate(
          100,
          (index) => Card(
              color: index % 2 == 0 ? Colors.redAccent : Colors.blueAccent,
              child: const SizedBox(
                height: 500,
                width: 280,
              )),
        ),
        onDeckEmpty: () => debugPrint("Card deck empty"),
        onLeftSwipe: (Card card) => debugPrint("Swiped left!"),
        onRightSwipe: (Card card) => debugPrint("Swiped right!"),
        swipeThreshold: MediaQuery.of(context).size.width / 4,
        minimumVelocity: 1000,
        cardWidth: 300,
        rotationFactor: 0.3 / 3.14,
        swipeAnimationDuration: const Duration(milliseconds: 200),
        disableDragging: false,
      ),
    ));

    // return Scaffold(
    //   backgroundColor: Colors.black,
    //   body: Stack(
    //     children: [
    //       Image.network(
    //         'https://i.guancha.cn/bbs/2023/03/28/20230328134156899.jpg?imageView2/2/w/500/format/jpg',
    //         height: Get.height - (Constants.cardHeight + 60),
    //         width: Get.width,
    //         fit: BoxFit.cover,
    //       ),
    //       SafeArea(
    //         child: Padding(
    //           padding: const EdgeInsets.all(20),
    //           child: CoolSwiper(
    //             children: List.generate(
    //               Data.colors.length,
    //               (index) => Container(
    //                 height: Constants.cardHeight,
    //                 padding: const EdgeInsets.all(40),
    //                 decoration: BoxDecoration(
    //                   color: Data.colors[index],
    //                   borderRadius: BorderRadius.circular(18),
    //                 ),
    //                 child: Align(
    //                   alignment: Alignment.bottomLeft,
    //                   child: Row(
    //                     crossAxisAlignment: CrossAxisAlignment.end,
    //                     mainAxisSize: MainAxisSize.min,
    //                     children: [
    //                       Container(
    //                         height: 40,
    //                         width: 40,
    //                         decoration: BoxDecoration(
    //                           color: Colors.black.withOpacity(0.2),
    //                           shape: BoxShape.circle,
    //                         ),
    //                       ),
    //                       const SizedBox(width: 15),
    //                       Column(
    //                         mainAxisAlignment: MainAxisAlignment.end,
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Container(
    //                             height: 15,
    //                             width: 150,
    //                             decoration: BoxDecoration(
    //                               color: Colors.black.withOpacity(0.2),
    //                               borderRadius: BorderRadius.circular(10),
    //                             ),
    //                           ),
    //                           const SizedBox(height: 10),
    //                           Container(
    //                             height: 15,
    //                             width: 100,
    //                             decoration: BoxDecoration(
    //                               color: Colors.black.withOpacity(0.2),
    //                               borderRadius: BorderRadius.circular(10),
    //                             ),
    //                           ),
    //                         ],
    //                       )
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
