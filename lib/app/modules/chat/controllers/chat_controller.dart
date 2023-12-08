import 'package:congle/app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  late final ShortProfile profile;
  late FocusNode focusNode;
  final crud = Get.put(ChatApi());
  final _hasFocus = false.obs;
  bool get hasFocus => _hasFocus.value;
  final TextEditingController tec = TextEditingController();
  final messages = <Chat>[].obs;

  final ScrollController scrollController = ScrollController();

  @override
  void onClose() {
    scrollController.dispose();
    _listWorker.dispose();
    super.onClose();
  }

  listOnChange(List<Chat> val) {
    messages.stream.handleError((onError) {
      // change(null, status: RxStatus.error(onError.toString()));
    });
    if (val.isEmpty) {
      // change(null, status: RxStatus.empty());
    } else {
      // change(val, status: RxStatus.success());
    }
  }

  late Worker _listWorker;
  @override
  void onInit() {
    profile = Get.arguments;
    messages.bindStream(crud.chatStream());
    _listWorker = ever(messages, listOnChange);
    focusNode = FocusNode()
      ..addListener(() {
        _hasFocus(focusNode.hasFocus);
      });
    super.onInit();
  }

  final _loading = false.obs;
  bool get loading => _loading.value;

  final _error = ''.obs;
  String get error => _error.value;

  Future<void> sendMessege(BuildContext context) async {
    try {
      FocusScope.of(context).unfocus();
      messages.add(
        Chat(
          id: "avc",
          time: DateTime.now(),
          senderId: Congle.currentUser!.uid,
          receiverId: profile.id,
          message: tec.text,
        ),
      );
      // await crud.addchat(
      //   chat: Chat(
      //     uidFrom: Congle.currentUser!.id,
      //     time: DateTime.now(),
      //     message: tec.text,
      //   ),
      // );

      tec.clear();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: 500.milliseconds,
        curve: Curves.easeIn,
      );
    } catch (e) {
      // messages.add(
      //   Chat(
      //     id: "avc",
      //     time: DateTime.now(),
      //     senderId: Congle.currentUser!.id,
      //     message: e.toString(),
      //   ),
      // );
      Get.log(e.toString());
      _loading(false);
    }
  }

  void onMoreOptionTap() {
    Get.bottomSheet(
      KMoreOptionSheet(
        tiles: [
          SheetOptionTile(() {}, 'Book your Meeting'),
          SheetOptionTile(() {}, 'Block & Report', true)
        ],
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
