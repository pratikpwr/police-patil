import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/views/screens/register/collect_register.dart';
import 'package:shared/shared.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CollectRegisterBloc>(context).add(GetCollectionData());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          COLLECTION_REGISTER,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocListener<CollectRegisterBloc, CollectRegisterState>(
        listener: (context, state) {
          if (state is CollectionLoadError) {
            debugPrint(state.message);
            showSnackBar(context, state.message);
          }
        },
        child: BlocBuilder<CollectRegisterBloc, CollectRegisterState>(
          builder: (context, state) {
            if (state is CollectionDataLoading) {
              return loading();
            } else if (state is CollectionDataLoaded) {
              return SafeArea(
                child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    physics: const BouncingScrollPhysics(),
                    child: ListView.builder(
                        itemCount: state.collectionResponse.collectData!.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return CollectionDetailWidget(
                            collect:
                                state.collectionResponse.collectData![index],
                          );
                        })),
              );
            } else if (state is CollectionLoadError) {
              if (state.message == 'Record Empty') {
                return noRecordFound();
              } else {
                return somethingWentWrong();
              }
            } else {
              return somethingWentWrong();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const CollectRegFormScreen();
          })).then((value) {
            BlocProvider.of<CollectRegisterBloc>(context)
                .add(GetCollectionData());
          });
        },
        child: const Icon(Icons.add, size: 24),
      ),
    );
  }
}

class CollectionDetailWidget extends StatelessWidget {
  const CollectionDetailWidget({Key? key, required this.collect})
      : super(key: key);
  final CollectionData collect;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: GREY_BACKGROUND_COLOR),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              collect.type!,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500),
            ),
            const Divider(),
            Text(
              collect.description!,
              style: GoogleFonts.poppins(fontSize: 15),
            ),
            Text(
              collect.address!,
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            const Divider(),
            Text(
              collect.date!.toIso8601String().substring(0, 10),
              style: GoogleFonts.poppins(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
