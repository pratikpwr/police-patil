import 'package:api/api.dart';
import 'package:shared/modules/disaster_tools/models/tools_model.dart';

class DisasterToolsRepository {
  Future<dynamic> getDisasterToolsRegisterByPP({required int userId}) async {
    final response = await ApiSdk.getDisasterToolsByPP(userId: userId);
    return response;
  }

  Future<dynamic> addDisasterToolsData({required ToolsData toolsData}) async {
    final body = toolsData.toJson();
    final response = await ApiSdk.postDisasterTools(body: body);
    return response;
  }
}
