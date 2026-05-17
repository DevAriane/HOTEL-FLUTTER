import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../controllers/SplashController.dart';

class Screen extends StatelessWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SplashController controller = Get.put(SplashController());

    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: AppColor.dGreen,
        ),
        body: Container(
            color: AppColor.dGreen,
            child: SafeArea(
                child: Center(
              child: Obx(() => AnimatedOpacity(
                  opacity: controller.opacite.value,
                  duration: Duration(seconds: 3),
                  curve: Curves.easeIn,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.bathroom_rounded,
                        color: AppColor.blanc,
                        size: 100,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text("aria'HOTEL",
                          style: GoogleFonts.nunito(
                              color: AppColor.blanc,
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                    ],
                  ))),
            ))));
  }
}
