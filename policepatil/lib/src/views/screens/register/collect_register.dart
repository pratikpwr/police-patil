import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:shared/shared.dart';

class CollectRegFormScreen extends StatefulWidget {
  CollectRegFormScreen({Key? key, this.collect}) : super(key: key);
  CollectionData? collect;

  @override
  State<CollectRegFormScreen> createState() => _CollectRegFormScreenState();
}

class _CollectRegFormScreenState extends State<CollectRegFormScreen> {
  bool _isEdit = false;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  Position? _position;

  String? chosenValue;

  final List<String> collectionType = <String>[
    "बेवारस वाहने",
    "दागिने",
    "गौण खनिज",
    "इतर"
  ];

  String photoName = "फोटो जोडा";
  File? photo;
  double longitude = 0.00;
  double latitude = 0.00;

  @override
  void initState() {
    super.initState();
    _initializeValues();
  }

  _initializeValues() {
    _isEdit = widget.collect != null;

    chosenValue = _isEdit ? widget.collect!.type : null;
    _dateController.text =
        _isEdit ? dateInYYYYMMDDFormat(widget.collect!.date) ?? '' : '';
    _addressController.text = _isEdit ? widget.collect!.address ?? '' : '';
    _detailsController.text = _isEdit ? widget.collect!.description ?? '' : '';
    photoName = _isEdit ? 'फोटो जोडलेले आहे' : 'फोटो जोडा';
    longitude = _isEdit ? widget.collect!.longitude ?? 0.00 : 0.00;
    latitude = _isEdit ? widget.collect!.latitude ?? 0.00 : 0.00;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(COLLECTION_REGISTER),
      ),
      body: BlocListener<CollectRegisterBloc, CollectRegisterState>(
        listener: (context, state) {
          if (state is CollectionDataSendError) {
            showSnackBar(context, state.error);
          }
          if (state is CollectionDataSent) {
            showSnackBar(context, state.message);
            Navigator.pop(context);
          }
          if (state is CollectionDataEdited) {
            showSnackBar(context, state.message);
            Navigator.pop(context);
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<CollectRegisterBloc, CollectRegisterState>(
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      spacer(),
                      buildDropButton(
                          value: chosenValue,
                          items: collectionType,
                          hint: "जप्ती मालाचा प्रकार निवडा",
                          onChanged: (String? value) {
                            setState(() {
                              chosenValue = value;
                            });
                          }),
                      spacer(),
                      buildTextField(_addressController, PLACE),
                      spacer(),
                      AttachButton(
                          text: SELECT_LOCATION,
                          icon: Icons.location_on_rounded,
                          onTap: () async {
                            _position = await determinePosition();
                            setState(() {
                              longitude = _position!.longitude;
                              latitude = _position!.latitude;
                            });
                          }),
                      spacer(),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("$LONGITUDE: $longitude",
                              style: Styles.subTitleTextStyle()),
                          const SizedBox(width: 12),
                          Text("$LATITUDE: $latitude",
                              style: Styles.subTitleTextStyle()),
                        ],
                      ),
                      spacer(),
                      buildDateTextField(context, _dateController, DATE),
                      spacer(),
                      buildTextField(_detailsController, "जप्ती मालाचे वर्णन"),
                      spacer(),
                      AttachButton(
                        text: photoName,
                        onTap: () {
                          getFileFromDevice(context).then((pickedFile) {
                            setState(() {
                              photo = pickedFile;
                              photoName = getFileName(pickedFile!.path);
                            });
                          });
                        },
                      ),
                      spacer(),
                      BlocBuilder<CollectRegisterBloc, CollectRegisterState>(
                        builder: (context, state) {
                          if (state is CollectionDataSending) {
                            return const Loading();
                          }
                          return CustomButton(
                              text: DO_REGISTER,
                              onTap: () {
                                _registerCollectionData(context);
                              });
                        },
                      )
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }

  _registerCollectionData(BuildContext context) async {
    CollectionData _collectionData = CollectionData(
      id: widget.collect?.id,
      type: chosenValue!,
      address: _addressController.text,
      date: parseDate(_dateController.text),
      description: _detailsController.text,
      latitude: latitude,
      longitude: longitude,
      photo: photo?.path != null
          ? await MultipartFile.fromFile(photo!.path)
          : null,
    );

    _isEdit
        ? BlocProvider.of<CollectRegisterBloc>(context)
            .add(EditCollectionData(_collectionData))
        : BlocProvider.of<CollectRegisterBloc>(context)
            .add(AddCollectionData(_collectionData));
  }
}
