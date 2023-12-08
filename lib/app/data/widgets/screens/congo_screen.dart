import 'package:congle/app/data/data.dart';
import 'package:congle/app/modules/bookingRequests/controllers/booking_requests_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class CongoScreen extends StatefulWidget {
  final DateRequest dateRequest;

  const CongoScreen({Key? key, required this.dateRequest}) : super(key: key);
  @override
  _CongoScreenState createState() => _CongoScreenState();
}

class _CongoScreenState extends State<CongoScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> sideAnimation;
  late Animation<double> heightAnimation;
  late AnimationController controller;
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();

    Get.put<BookingRequestsController>(BookingRequestsController());

    controller = AnimationController(vsync: this, duration: 400.milliseconds);

    sideAnimation = Tween<double>(begin: -180, end: Get.width * 0.5 - 130)
        .animate(controller)
      ..addListener(() {
        setState(() {});
      });
    heightAnimation =
        Tween<double>(begin: Get.height * 0.75, end: Get.height * 0.37)
            .animate(controller)
          ..addListener(() {
            setState(() {});
          });

    controller.forward();
    playAudio();
  }

  Future<void> playAudio() async {
    await player.setAsset('assets/audio/date.ogg');
    await player.play();
  }

  @override
  void dispose() {
    controller.dispose();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            color: Get.theme.cardColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 25),
                Text(
                  'Congratulation!',
                  style: Get.textTheme.headline1!
                      .copyWith(color: Colors.black, fontSize: 40),
                ),
                const SizedBox(height: 5),
                Text(
                  'One more connection on the way. You can check these accepted profiles in the booking tab.',
                  style: Get.textTheme.caption!.copyWith(
                      color: Colors.black87,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: KButton(
                    title: 'Book your meeting',
                    onPressed: () {
                      Get.back();
                      Get.find<BookingRequestsController>()
                          .pendingBookMeeting(widget.dateRequest);
                    },
                    // bRadius: 15,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: KOutlineButton(
                    title: 'Interact via chat',
                    // bRadius: 15,
                    isTextWhite: false,
                    onPressed: () {
                      Get.back();
                      Get.find<BookingRequestsController>()
                          .pendingChat(widget.dateRequest.profile);
                    },
                  ),
                ),
                const SizedBox(height: 5),
                InkWell(
                    onTap: () => Get.back(),
                    child: Text(
                      'Back',
                      style: Get.textTheme.button!
                          .copyWith(color: Get.theme.colorScheme.secondary),
                    )),
                const SizedBox(height: 15),
              ],
            ),
          ),
          Positioned(
            top: heightAnimation.value,
            right: sideAnimation.value,
            child: CircleAvatar(
              radius: 75,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 75 - 2,
                backgroundColor: Get.theme.backgroundColor,
                backgroundImage: NetworkImage(Congle.currentUser!.dp),
              ),
            ),
          ),
          Positioned(
            top: heightAnimation.value,
            left: sideAnimation.value,
            child: CircleAvatar(
              radius: 75,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 75 - 2,
                backgroundColor: Get.theme.backgroundColor,
                backgroundImage: NetworkImage(widget.dateRequest.profile.dp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
