import 'package:congle/app/data/data.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: kcBg,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16, top: 5),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: kcBlack,
                  ),
                ),
                const SizedBox(width: 2),
                CircleAvatar(
                  backgroundImage: NetworkImage(controller.profile.dp),
                  maxRadius: 20,
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: GestureDetector(
                    onTap: () =>
                        Get.to(ProfileDetailsScreen(id: controller.profile.id)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          controller.profile.name,
                          style: Get.textTheme.headline5,
                        ),
                        // const SizedBox(height: 3),
                        Text(
                          "Time Left: ${FormatNumber(100)}",
                          style: Get.textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () => controller.onMoreOptionTap(),
                    icon: const Icon(
                      Icons.more_vert_rounded,
                      color: Colors.black,
                    )),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: kcBg,
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: controller.messages.length,
            padding: const EdgeInsets.only(top: 5, bottom: 80),
            controller: controller.scrollController,
            reverse: true,
            itemBuilder: (context, index) {
              return ChatMessageContainer(
                  message: controller.messages.reversed.toList()[index]);
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 80,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 15),
                  Expanded(
                    child: KTextField(
                      focusNode: controller.focusNode,
                      controller: controller.tec,
                      hintText: "Write message...",
                      textInputType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(width: 15),
                  FloatingActionButton(
                    onPressed: () => controller.sendMessege(context),
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: kcAccent,
                    elevation: 0,
                  ),
                  const SizedBox(width: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessageContainer extends StatelessWidget {
  const ChatMessageContainer({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Chat message;

  @override
  Widget build(BuildContext context) {
    bool isMe = message.senderId != Congle.currentUser!.uid;
    return Container(
      padding: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: Align(
        alignment: (isMe ? Alignment.topLeft : Alignment.topRight),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: isMe ? Radius.zero : const Radius.circular(16),
                  bottomRight: isMe ? const Radius.circular(16) : Radius.zero,
                ),
                color: isMe
                    ? const Color(0xff5B4E46).withOpacity(0.3)
                    : kcAccent.withOpacity(0.3),
              ),
              padding: const EdgeInsets.all(16),
              child: Text(
                message.message,
                style: Get.textTheme.bodyText2!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 5),
              child: Text(
                DateFormat('hh:mm a').format(message.time),
                style: Get.textTheme.bodyText2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
