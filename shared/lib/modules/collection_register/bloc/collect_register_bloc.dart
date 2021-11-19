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
    if (event is EditCollectionData) {
      yield* _mapEditCollectionDataState(event);
    }
    if (event is DeleteCollectionData) {
      yield* _mapDeleteCollectionDataState(event);
    }
  }

  Stream<CollectRegisterState> _mapGetCollectionDataState(
      GetCollectionData event) async* {
    yield CollectionDataLoading();
    try {
      Response _response = await _collectionRepository.getCollectionsRegister();
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

  Stream<CollectRegisterState> _mapEditCollectionDataState(
      EditCollectionData event) async* {
    yield CollectionDataSending();
    try {
      Response _response = await _collectionRepository.editArmsData(
          collect: event.collectionData);

      if (_response.data["message"] != null) {
        yield CollectionDataEdited(_response.data["message"]);
      } else {
        yield CollectionDataSendError(_response.data["error"]);
      }
    } catch (err) {
      yield CollectionDataSendError(err.toString());
    }
  }

  Stream<CollectRegisterState> _mapDeleteCollectionDataState(
      DeleteCollectionData event) async* {
    yield CollectionDataLoading();
    try {
      Response _response = await _collectionRepository.deleteArmsData(
        id: event.id,
      );

      if (_response.data["message"] != null) {
        yield CollectionDataDeleted();
      } else {
        yield CollectionLoadError(_response.data["error"]);
      }
    } catch (err) {
      yield CollectionLoadError(err.toString());
    }
  }
}
