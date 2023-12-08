import 'package:congle/app/data/data.dart';
import 'package:congle/app/modules/bookingRequests/controllers/booking_requests_controller.dart';
import 'package:congle/app/modules/activities/views/components/datetime_sheet.dart';
import 'package:get/get.dart';

class ActivitiesController extends GetxController {
  DateTime dateTime = DateTime.now();
  DateRequest? dateRequest;
  final ActivityApi activityApi = Get.find<ActivityApi>();
  RxList<String> savedActivities = RxList.empty();

  @override
  void onInit() {
    super.onInit();
    dateRequest = Get.arguments;
    getSavedActivities();
  }

  @override
  void onClose() {}

  Future<List<ActivityCategory>> getCategories() async =>
      await activityApi.getCategories();

  Future<List<ShortActivity>> getRecommended() async =>
      await activityApi.getRecommendedActivities();

  Future<List<ShortActivity>> getCategoryActivities(
          ActivityCategory cat) async =>
      await activityApi.getCategoryActivities(cat);

  Future<Activity?> getActivity(String id) async =>
      await activityApi.getActivityById(id);

  Future<List<String>> getAds() async => await activityApi.getAds();

  Future<void> getSavedActivities() async {
    await activityApi.getSavedActivities().then((value) {
      savedActivities.clear();
      savedActivities.addAll(value);
    });
  }

  void saveCafe(String id) async {
    await activityApi.saveActivityById(id).then((value) {
      KSuccessToast("Cafe Saved/Unsaved");
      getSavedActivities();
    });
  }

  void onActivityTap(ShortActivity activity) =>
      Get.to(() => ActivityDetailsScreen(
            id: activity.id,
            isSaved: savedActivities.contains(activity.id).obs,
            onSave: () => saveCafe(activity.id),
            mainButton: KButton(
              title: 'Book Your Meating',
              onPressed: () => bookMeeting(activity),
              fontSize: 20,
            ),
          ));

  void bookMeeting(ShortActivity activity) {
    dateTime = DateTime.now();
    Get.bottomSheet(
      DateTimeSheet(
        id: activity.id,
        dateRequest: dateRequest!,
      ),
    );
  }

  void onDateChange(DateTime value) {
    dateTime = DateTime(
        value.year, value.month, value.day, dateTime.hour, dateTime.minute);
    update();
  }

  void confirmBooking(DateRequest dateRequest, ShortActivity activity) {
    Get.find<BookingRequestsController>()
        .addBooking(dateRequest, activity, dateTime);
  }

  void onTimeChange(DateTime value) {
    dateTime = DateTime(
        dateTime.year, dateTime.month, dateTime.day, value.hour, value.minute);
    update();
  }
}
