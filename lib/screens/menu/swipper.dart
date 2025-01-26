import 'package:flutter/material.dart';
import 'package:swipe_deck/swipe_deck.dart';

class Swipercard extends StatelessWidget {
  final IMAGES = ["card", "card", "card"];
  final borderRadius = BorderRadius.circular(20.0);

  Swipercard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: SwipeDeck(
          aspectRatio: 9 / 4,
          startIndex: 0,
          emptyIndicator: const Center(
            child: Text("Nothing Here"),
          ),
          cardSpreadInDegrees: 5, // Change the Spread of Background Cards
          onSwipeLeft: () {
            print("USER SWIPED LEFT -> GOING TO NEXT WIDGET");
          },
          onSwipeRight: () {
            print("USER SWIPED RIGHT -> GOING TO PREVIOUS WIDGET");
          },
          onChange: (index) {
            print(IMAGES[index]);
          },
          widgets: IMAGES
              .map((e) => GestureDetector(
                    onTap: () {
                      print(e);
                    },
                    child: ClipRRect(
                        borderRadius: borderRadius,
                        child: Image.asset(
                          "assets/images/$e.png",
                          fit: BoxFit.contain,
                        )),
                  ))
              .toList(),
        ),
      ),
    ));
  }
}
