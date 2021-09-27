import 'package:api/api.dart';
import 'package:shared/modules/collection_register/models/collect_model.dart';

class CollectRepository {
  Future<dynamic> getCollectionsRegisterByPP({required int userId}) async {
    final response = await ApiSdk.getCollectByPP(userId: userId);
    return response;
  }

  Future<dynamic> addCollectionsData(
      {required CollectionData collectionData}) async {
    final body = collectionData.toJson();
    final response = await ApiSdk.postCollectRegister(body: body);
    return response;
  }
}
