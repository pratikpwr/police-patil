import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared/modules/collection_register/models/collect_model.dart';
import 'package:shared/modules/collection_register/resources/collect_repository.dart';
import 'package:dio/dio.dart';
import '../../../shared.dart';

part 'collect_register_event.dart';

part 'collect_register_state.dart';

class CollectRegisterBloc
    extends Bloc<CollectRegisterEvent, CollectRegisterState> {
  CollectRegisterBloc() : super(CollectionRegisterInitial());
  final _collectionRepository = CollectRepository();

  @override
  Stream<CollectRegisterState> mapEventToState(
    CollectRegisterEvent event,
  ) async* {
    if (event is GetCollectionData) {
      yield* _mapGetCollectionDataState(event);
    }
    if (event is AddCollectionData) {
      yield* _mapAddCollectionDataState(event);
    }
  }

  Stream<CollectRegisterState> _mapGetCollectionDataState(
      GetCollectionData event) async* {
    final sharedPrefs = await prefs;
    yield CollectionDataLoading();
    try {
      int? userId = sharedPrefs.getInt('userId');
      Response _response = await _collectionRepository
          .getCollectionsRegisterByPP(userId: userId!);
      if (_response.statusCode! < 400) {
        final _collectionResponse = CollectionResponse.fromJson(_response.data);
        yield CollectionDataLoaded(_collectionResponse);
      } else {
        yield CollectionLoadError(_response.data["error"]);
      }
    } catch (err) {
      yield CollectionLoadError(err.toString());
    }
  }

  Stream<CollectRegisterState> _mapAddCollectionDataState(
      AddCollectionData event) async* {
    yield CollectionDataSending();
    try {
      final sharedPrefs = await prefs;
      event.collectionData.ppid = sharedPrefs.getInt('userId')!;
      event.collectionData.psid = sharedPrefs.getInt('policeStationId')!;

      Response _response = await _collectionRepository.addCollectionsData(
          collectionData: event.collectionData);

      if (_response.data["message"] != null) {
        yield CollectionDataSent(_response.data["message"]);
      } else {
        yield CollectionDataSendError(_response.data["error"]);
      }
    } catch (err) {
      yield CollectionDataSendError(err.toString());
    }
  }
}
