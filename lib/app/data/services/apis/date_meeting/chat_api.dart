import 'package:get/get.dart';

import '../../../data.dart';

class ChatApi {
  late Api api;
  Future<ChatApi> init() async {
    Get.log('$runtimeType ready');
    api = Get.find<Api>();
    return this;
  }
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final _firebase = Get.put(FirebaseService<Chat>());

  // static const Collection = FirebaseCollections.CHAT;

  Stream<List<Chat>> chatStream() {
    // return _firebase.getListStream(
    //   collection: Collection,
    //   returnVal: (query) {
    //     List<Chat> retVal = List();
    //     query.docs.forEach((element) async {
    //       retVal.add(
    //         Chat.fromDocumentSnapshot(
    //           documentSnapshot: element,
    //         ),
    //       );
    //     });
    //     return retVal;
    //   },
    // );
    return const Stream.empty();
  }

  Future<String> addchat({required Chat chat}) {
    // final _data = {
    //   "dateCreated": DateTime.now(),
    //   "uidFrom": chat.uidFrom,
    //   "uidTo": chat.uidTo,
    //   "messege": chat.messege,
    // };
    // return _firebase.crud(
    //   CrudState.add,
    //   collection: Collection,
    //   model: chat,
    //   wantLoading: false,
    //   data: _data,
    // );
    return Future.value(chat.message);
  }

  void updatechat({required Chat chat}) {
    // _firestore
    //     .collection("chat")
    //     .doc(chat.id)
    //     .update({
    //       "uidFrom": chat.uidFrom,
    //       "uidTo": chat.uidTo,
    //       "messege": chat.messege,
    //     })
    //     .then((value) => print('success'))
    //     .catchError((err) {
    //       print(err.message);
    //       print(err.code);
    //     });
  }

  void deleteChat({required String id}) {
    // _firestore
    //     .collection("chat")
    //     .doc(id)
    //     .delete()
    //     .then((value) => print('success'))
    //     .catchError((err) {
    //   print(err.message);
    //   print(err.code);
    // });
  }
}
