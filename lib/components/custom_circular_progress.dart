import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../components/custom_text.dart';

class CustomCircularProgress extends StatelessWidget {
  const CustomCircularProgress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double loadingWidth = width * 0.5;
    final double loadingHeight = width * 0.3;

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildLoadingText(),
                  _buildLoadingGif(loadingWidth, loadingHeight),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingText() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: CustomText(
        text: 'loading...',
        color: greenDefault,
        fontSize: 32,
      ),
    );
  }

  Widget _buildLoadingGif(double width, double height) {
    return Image.asset(
      'assets/images/loading.gif',
      width: width,
      height: height,
      fit: BoxFit.contain,
    );
  }
}

