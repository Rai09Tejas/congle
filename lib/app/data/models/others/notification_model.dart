class NotificationModel {
  final String? title;
  final String subTitle;
  final DateTime time;
  final String imageUrl;
  final String? route;
  bool isRead;
  final DateTime exipireTime;

  NotificationModel(
      {this.title,
      required this.subTitle,
      required this.time,
      required this.exipireTime,
      required this.imageUrl,
      this.isRead = false,
      this.route});
}
