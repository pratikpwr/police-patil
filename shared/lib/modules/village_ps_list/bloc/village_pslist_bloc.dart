import 'dart:async';
import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared/modules/village_ps_list/models/ps_list_model.dart';
import 'package:shared/modules/village_ps_list/models/villages_list_model.dart';
import 'package:shared/modules/village_ps_list/resources/village_ps_repository.dart';

part 'village_pslist_event.dart';

part 'village_pslist_state.dart';

class VillagePSListBloc extends Bloc<VillagePSListEvent, VillagePSListState> {
  VillagePSListBloc() : super(VillagePSListInitial());
  final _listRepository = VillagePSListRepository();

  List<Village>? villages;
  List<PoliceStation>? policeStations;

  @override
  Stream<VillagePSListState> mapEventToState(
    VillagePSListEvent event,
  ) async* {
    if (event is GetVillagePSList) {
      yield VillagePSListLoading();
      try {
        Response _villageRes = await _listRepository.getVillageList();
        Response _psRes = await _listRepository.getPSList();

        if (_villageRes.data['message'] != null &&
            _psRes.data['message'] != null) {
          final _psList = PsList.fromJson(_psRes.data);
          final _villageList = VillageList.fromJson(_villageRes.data);
          villages = _villageList.data!;
          policeStations = _psList.data!;
          yield VillagePSListSuccess(_psList.data!, _villageList.data!);
        }
      } catch (err) {
        yield VillagePSListFailed(err.toString());
      }
    }
  }
}
