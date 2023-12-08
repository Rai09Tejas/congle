import 'package:congle/app/data/data.dart';
import 'package:congle/app/modules/activities/controllers/activities_controller.dart';
import 'package:congle/app/modules/activities/views/booking_completed_screen.dart';
import 'package:congle/app/modules/activities/views/components/datetime_sheet.dart';
import 'package:congle/app/modules/dateRequests/views/dialogs/date_confirm_dialog.dart';
import 'package:congle/app/modules/home/controllers/home_controller.dart';
import 'package:congle/app/modules/notifications/controllers/notifications_controller.dart';
import 'package:congle/app/routes/app_pages.dart';
import 'package:congle/packages/packages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingRequestsController extends GetxController {
  // String? _nav;
  TabController? tabController;
  DateRequest? currentDateRequest;
  List<Booking> pendingMeetList = [];
  List<Booking> bookings = [];
  List<Booking> queueMeetList = [];
  List<Booking> completedMeetList = [];

  final bookingApi = Get.find<BookingsApi>();

  // @override
  // void onInit() {
  //   super.onInit();
  // _nav = Get.parameters['pg'].toString();

  // List<Booking> _list = [
  //   for (var i = 0; i < demoProfilesShort.length; i++)
  //     Booking(
  //         id: 'uid0',
  //         bookie: mainProfileShort,
  //         isRescheduled: false,
  //         attendies: [demoProfilesShort[i]],
  //         initTime: DateTime.now().subtract((i * 10).days),
  //         activity: ShortActivity.fromJson(demoCafes.first.toJson()),
  //         bookingTime: DateTime.now().subtract((i * 8).days)),
  // ];
  // completedMeetList.addAll(_list);
  // }

  @override
  void onClose() {}

  void initTabController({required TickerProvider vsync}) {
    String _nav = Get.parameters['pg'].toString();
    int initIndex = 0;
    if (_nav != '') {
      if (_nav == 'completed') {
        initIndex = 2;
      } else if (_nav == 'upcoming') {
        initIndex = 1;
      } else {
        initIndex = 0;
      }
    }

    tabController = TabController(
      initialIndex: initIndex,
      length: 3,
      vsync: vsync,
    );
  }

  Future<List<Booking>> getCompletedMeets() async =>
      await bookingApi.getCompletedBookings();
  Future<List<Booking>> getUpcommingMeets() async =>
      await bookingApi.getUpcommingBookings();
  Future<List<Booking>> getPendingMeets() async =>
      await bookingApi.getPendingBookings();

  // final List<Booking> bookings = await bookingApi.getPendingBookings();
  // bookings.removeWhere((e) => (e.bookie.id != Congle.currentUser!.id));
  // return bookings;

  Future<List<ShortProfile>> getQueueMeets() async =>
      await bookingApi.getQueueBookings();

  Future<void> pendingChat(ShortProfile profile) async {
    await Get.dialog(
      DateConfirmDialog(
        button: KButton(
            title: "Send Your first message",
            solidColor: kcWhite,
            textColor: kcBlack,
            onPressed: () {
              Get.back();
              Get.toNamed(Routes.CHAT, arguments: profile);
            }),
        showGif: false,
        title: 'It’s time to know them',
        subtitle:
            'This chat option will be available for next 24 hours for both of you. For using this option futher you have to book your meeting at our meeting venues.',
      ),
      transitionCurve: Curves.easeInOutSine,
    );
    // Get.toNamed(Routes.CHAT, arguments: profile);
  }

  void pendingBookMeeting(DateRequest dateRequest) {
    currentDateRequest = dateRequest;
    update();
    Get.toNamed(Routes.ACTIVITIES, arguments: dateRequest);
  }

  Future<void> callCafe(ShortActivity activity) async {
    var urlString = "tel:${activity.phno}";
    Get.log(urlString);
    await launch(urlString);
    canLaunch(urlString).then((value) async {
      if (value) {
        await launch(urlString);
        return;
      }
    });
  }

  void reschedule(Booking booking) {
    Get.find<ActivitiesController>().dateTime = DateTime.now();
    Get.bottomSheet(
      DateTimeSheet(
        id: booking.activity!.id,
        initDateTime: booking.initTime,
        onReschedule: () async {
          booking.bookingTime = Get.find<ActivitiesController>().dateTime;
          await bookingApi.rescheduleBooking(booking.bookingTime!, booking.id);
          update();
          Get.back();
          Get.find<HomeController>().updatePageIndex(3);
        },
        dateRequest: currentDateRequest!,
      ),
    );
  }

  Future<void> completedMeetAgain(Booking meet) async {
    Get.dialog(
      const LoadingDots.long(),
      barrierDismissible: false,
    );
    await bookingApi.meetAgain(meet.id).then((value) {
      if (value) {
        Get.back();
        tabController!.animateTo(1);
      } else {
        Get.back();
        KErrorToast();
      }
    });
  }

  void completedMoreOptions(Booking meet) {
    Get.bottomSheet(
      KMoreOptionSheet(
        tiles: [
          SheetOptionTile(() => deleteCompletedMeet(meet), 'Delete'),
          SheetOptionTile(
              () => deleteCompletedMeet(meet), 'Block & Report', true)
        ],
      ),
      backgroundColor: Colors.transparent,
    );
  }

  Future<void> addBooking(
      DateRequest dateRequest, ShortActivity activity, DateTime time) async {
    if (currentDateRequest != null) {
      Get.dialog(
        const LoadingDots.long(
          color: kcWhite,
        ),
        barrierDismissible: false,
      );
      //   bookings.add(new Booking(
      //     id: dateRequest.id,
      //     isRescheduled: false,
      //     initTime: DateTime.now(),
      //     attendies: [dateRequest.profile],
      //     bookie: ShortProfile.fromMap(Congle.currentUser!.toMap()),
      //     activity: activity,
      //     bookingTime: time,
      //   ));
      // print(activity.id);

      bool isBooked = false;
      try {
        isBooked = await bookingApi.scheduleBooking(
            time, currentDateRequest!.id, activity.id);
      } on Exception catch (e) {
        KErrorToast(msg: e.toString());
        Navigator.popUntil(Get.context!, ModalRoute.withName(Routes.HOME));

        return;
      }
      if (!isBooked) {
        KErrorToast();
        Navigator.popUntil(Get.context!, ModalRoute.withName(Routes.HOME));
        return;
      }
      Booking bookingInfo =
          await bookingApi.getBookingInfo(currentDateRequest!.id);

      // pendingMeetList.removeWhere((e) => e.bookie == currentDateRequest!);
      Get.find<NotificationsController>().addNotification(NotificationModel(
          title: 'Booking Confirmed',
          subTitle:
              "Your booking with ${activity.name} is confirmed with ${currentDateRequest!.profile.name}",
          time: DateTime.now(),
          exipireTime: DateTime.now().add(5.minutes),
          route: Routes.BOOKING_UPCOMING_REQUESTS,
          imageUrl: activity.dp.first));
      // Booking booking = await bookingApi.getScheduleBooking();
      tabController!.animateTo(1);
      Navigator.popUntil(Get.context!, ModalRoute.withName(Routes.HOME));
      Get.to(() => BookingCompleted(
            booking: bookingInfo,
          ));
    }
  }

  void deleteCompletedMeet(Booking meet) async {
    Get.dialog(
      const LoadingDots.long(
        color: kcWhite,
      ),
      barrierDismissible: false,
    );
    bool isDeleted = false;
    try {
      isDeleted = await Get.find<DatesApi>().removeDateProfile(meet.id);
    } on Exception catch (e) {
      KErrorToast(msg: e.toString());
      Navigator.popUntil(Get.context!, ModalRoute.withName(Routes.HOME));

      return;
    }
    if (isDeleted) {
      Get.back();
      tabController!.animateTo(0);
    }
    update();
    Get.back();
  }

  void onBookingTileTap(Booking booking) {
    Get.bottomSheet(
      KMoreOptionSheet(
        tiles: [
          SheetOptionTile(() {
            Get.back();
            Get.to(() => null);
          }, '➰ Open Chat'),
          SheetOptionTile(() {
            Get.back();
            Get.to(() => ActivityDetailsScreen(
                  id: booking.activity!.id,
                  showSave: false,
                ));
          }, 'Open Activity'),
          if (booking.attendies.length == 1)
            SheetOptionTile(() {
              Get.back();
              Get.to(() => ProfileDetailsScreen(
                  id: Congle.currentUser!.uid == booking.bookie.id
                      ? booking.attendies.first.id
                      : booking.bookie.id));
            }, 'Open Profile')
          else ...[
            SheetOptionTile(() {
              Get.back();
              Get.to(() => ProfileDetailsScreen(id: booking.bookie.id));
            }, "Admin's Profile"),
            SheetOptionTile(() => Get.back(), 'See Attendies List')
          ],
          if (Congle.currentUser!.uid == booking.bookie.id ||
              booking.attendies.length == 1)
            SheetOptionTile(() => Get.back(), 'Cancel Meeting', true)
          else
            SheetOptionTile(() => Get.back(), 'Opt. Out of Meeting', true),
        ],
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
