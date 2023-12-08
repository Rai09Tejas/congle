import 'package:congle/app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingCompleted extends StatefulWidget {
  const BookingCompleted({Key? key, required this.booking}) : super(key: key);

  final Booking booking;

  @override
  _BookingCompletedState createState() => _BookingCompletedState();
}

class _BookingCompletedState extends State<BookingCompleted> {
  final player = AudioPlayer();
  @override
  void initState() {
    super.initState();
    playAudio();
  }

  Future<void> playAudio() async {
    await player.setAsset('assets/audio/date.ogg');
    await player.play();
  }

  @override
  void dispose() {
    player.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: const EdgeInsets.all(5),
        color: Get.theme.cardColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: Get.mediaQuery.padding.top),
            SizedBox(
              height: 100,
              child: Image.asset(
                "assets/gifs/confirm.gif",
                fit: BoxFit.contain,
              ),
            ),
            Column(
              children: [
                Text(
                  'Booking Succesful',
                  style: Get.textTheme.headline6!
                      .copyWith(color: Colors.black, fontSize: 25),
                ),
                Text(
                  'Congratulation!\nWe are very excited for your meeting.\nKeep connecting with new people on congle.',
                  style:
                      Get.textTheme.bodyText2!.copyWith(color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            TicketContainer(
              width: Get.width * 0.8,
              height: 400,
              childUp: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Booking Details',
                    style:
                        Get.textTheme.headline6!.copyWith(color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: Get.width * 0.03),
                        Container(
                          alignment: Alignment.center,
                          width: Get.width * 0.25,
                          child: ManyMergedImageContainer(
                            images: [
                              widget.booking.bookie.dp,
                              widget.booking.attendies.first.dp,
                            ],
                            imageLimit: 2,
                            widthFactor: 0.70,
                          ),
                        ),
                        Expanded(
                            child: NameNInfoContainer(
                                profile: widget.booking.attendies.first,
                                isSmall: true)),
                      ],
                    ),
                  )
                ],
              ),
              childDown: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: ActivityNameNInfoContainer(
                      activityShort: widget.booking.activity,
                      time: widget.booking.bookingTime,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.width * 0.4,
                          child: ManyMergedImageContainer(
                            images: widget.booking.activity!.dp,
                            imageLimit: 3,
                            widthFactor: 0.65,
                          ),
                        ),
                        Expanded(
                            child: Column(
                          children: [
                            KButton(title: 'Directions', onPressed: () {}),
                            const SizedBox(height: 5),
                            KOutlineButton(
                              title: 'Contact',
                              onPressed: () async {
                                var urlString =
                                    "tel:${widget.booking.activity!.phno}";
                                Get.log(urlString);
                                await launch(urlString);
                              },
                              isTextWhite: false,
                            ),
                          ],
                        )),
                      ],
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () => Get.back(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Back',
                  style: Get.textTheme.bodyText2!
                      .copyWith(color: Colors.black, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
