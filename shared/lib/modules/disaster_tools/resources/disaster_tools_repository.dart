import 'package:api/api.dart';
import 'package:shared/modules/disaster_tools/models/tools_model.dart';

class DisasterToolsRepository {
  Future<dynamic> getDisasterToolsRegister() async {
    final response = await ApiSdk.getDisasterTools();
    return response;
  }

  Future<dynamic> addDisasterToolsData({required ToolsData toolsData}) async {
    final body = toolsData.toJson();
    final response = await ApiSdk.postDisasterTools(body: body);
    return response;
  }
}
