import 'package:flutter/material.dart';
import 'package:flutter_app/utils/image_utils.dart';
import 'package:get/get.dart';

import '../../base/page/app_getx_base_page.dart';
import '../../generated/assets.dart';
import 'splash_logic.dart';

class SplashPage extends AppGetXBasePage<SplashLogic> {
  const SplashPage({super.key});

  @override
  bool showLoadingPage() {
    return false;
  }

  @override
  bool showTitle() {
    return false;
  }

  @override
  Widget buildChild(BuildContext context) {
    var stack = Stack(
      fit: StackFit.expand,
      children: [
        Assets.imagesStartUp.toAssetImageWidget(fit: BoxFit.fill),
        _buildBottom(),
      ],
    );
    return stack;
  }

  Widget _buildBottom() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            _buildLineText(),
          ],
        ),
      ),
    );
  }

  Widget _buildLineText() {
    return Obx(() => Text(controller.lineTextObs.value));
  }

  @override
  SplashLogic createController() {
    return SplashLogic();
  }
}
