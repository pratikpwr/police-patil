import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/views/screens/register/arms_register.dart';

class ArmsScreen extends StatelessWidget {
  const ArmsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ARMS_COLLECTIONS,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            physics: const BouncingScrollPhysics(),
            child: ListView.builder(
                itemCount: data.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ArmsDetailWidget(
                    armsData: data[index],
                  );
                })),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const ArmsRegFormScreen();
          }));
        },
        child: const Icon(Icons.add, size: 24),
      ),
    );
  }
}

class ArmsDetailWidget extends StatelessWidget {
  const ArmsDetailWidget({Key? key, required this.armsData}) : super(key: key);
  final ArmsModel armsData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (ctx) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                child: Column(
                  children: [
                    Text(
                      armsData.prakar,
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500),
                    ),
                    const Divider(),
                    Text(
                      armsData.name,
                      style: GoogleFonts.poppins(fontSize: 15),
                    ),
                    Text(
                      armsData.mobNo,
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    Text(
                      armsData.address,
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    Text(
                      "परवाना क्रमांक : ${armsData.certNo}",
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    Text(
                      "परवान्याची वैधता कालावधी : ${armsData.certVal}",
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                  ],
                ),
              );
            });
      },
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
              armsData.prakar,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500),
            ),
            const Divider(),
            Text(
              armsData.name,
              style: GoogleFonts.poppins(fontSize: 15),
            ),
            Text(
              armsData.address,
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            const Divider(),
            Text(
              "परवाना क्रमांक : ${armsData.certNo}4",
              style: GoogleFonts.poppins(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class ArmsModel {
  String prakar;
  String name;
  String mobNo;
  String aadharImage;
  String address;
  double lat;
  double long;
  String certNo;
  String certVal;
  String cerImage;

  ArmsModel(
      {required this.prakar,
      required this.name,
      required this.mobNo,
      required this.aadharImage,
      required this.address,
      required this.lat,
      required this.long,
      required this.certNo,
      required this.certVal,
      required this.cerImage});
}

List<ArmsModel> data = [
  ArmsModel(
      prakar: "शस्त्र परवानाधारक",
      name: "प्रतिक सतीश पवार",
      mobNo: "9168919081",
      aadharImage:
          "https://hindi.cdn.zeenews.com/hindi/sites/default/files/2021/05/11/822175-aadhaar-card-1105.jpg",
      address: "मुळेगाव, जुन्नर, पुणे",
      lat: 21.484934,
      long: 123.4279,
      certNo: "3249856983465984",
      certVal: "21/10/2022",
      cerImage:
          "https://data2.unhcr.org/images/documents/big_aa2c81585e808b644ef70587136c23601d33a2e9.jpg"),
  ArmsModel(
      prakar: "स्फोटक पदार्थ विक्री",
      name: "प्रतिक सतीश पवार",
      mobNo: "9168919081",
      aadharImage:
          "https://hindi.cdn.zeenews.com/hindi/sites/default/files/2021/05/11/822175-aadhaar-card-1105.jpg",
      address: "मुळेगाव, जुन्नर, पुणे",
      lat: 21.484934,
      long: 123.4279,
      certNo: "3249856983465984",
      certVal: "21/10/2022",
      cerImage:
          "https://data2.unhcr.org/images/documents/big_aa2c81585e808b644ef70587136c23601d33a2e9.jpg"),
  ArmsModel(
      prakar: "स्फोटक जवळ बाळगणारे",
      name: "प्रतिक सतीश पवार",
      mobNo: "9168919081",
      aadharImage:
          "https://hindi.cdn.zeenews.com/hindi/sites/default/files/2021/05/11/822175-aadhaar-card-1105.jpg",
      address: "मुळेगाव, जुन्नर, पुणे",
      lat: 21.484934,
      long: 123.4279,
      certNo: "3249856983465984",
      certVal: "21/10/2022",
      cerImage:
          "https://data2.unhcr.org/images/documents/big_aa2c81585e808b644ef70587136c23601d33a2e9.jpg"),
  ArmsModel(
      prakar: "शस्त्र परवानाधारक",
      name: "प्रतिक सतीश पवार",
      mobNo: "9168919081",
      aadharImage:
          "https://hindi.cdn.zeenews.com/hindi/sites/default/files/2021/05/11/822175-aadhaar-card-1105.jpg",
      address: "मुळेगाव, जुन्नर, पुणे",
      lat: 21.484934,
      long: 123.4279,
      certNo: "3249856983465984",
      certVal: "21/10/2022",
      cerImage:
          "https://data2.unhcr.org/images/documents/big_aa2c81585e808b644ef70587136c23601d33a2e9.jpg"),
];
