import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/utils/Constants.dart';
import 'package:untitled2/features/onboarding/presentation/manger/on_boarding/on_boarding_cubit.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController();

  int currentPage = 0;

  List<String> screens = ['firstScreen', 'secondScreen', 'thirdScreen', 'fourthScreen'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OnBoardingCubit, OnBoardingState>(
        builder: (context, state) {
          final cubit = BlocProvider.of<OnBoardingCubit>(context);
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesNames.loginView);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Skip",
                        style: TextStyle(color: Colors.black, fontSize: 15.sp),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: cubit.onBoardingScreens.length,
                      onPageChanged: (index) {
                        currentPage = index;
                        cubit.changeOnboardingScreen(screens[index]);
                      },
                      itemBuilder: (context, index) {
                        final screenData = cubit.onBoardingScreens.values.elementAt(index);
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: double.infinity,
                              color: Color(0XFFFAFBFD),
                              child: Column(
                                children: [
                                  Text(
                                    "Welcome to",
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 13.sp),
                                  ),
                                  Text(
                                    "MINI",
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20.sp),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height / 2,
                              width: double.infinity,
                              child: Image.asset(
                                screenData['img'],
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(screens.length, (index) {
                                return InkWell(
                                  onTap: () {
                                    if (index == screens.length) {
                                      Navigator.pushNamed(context, RoutesNames.loginView);
                                    } else {
                                      _pageController.animateToPage(
                                        index,
                                        duration: const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 650),
                                    margin: const EdgeInsets.symmetric(horizontal: 5),
                                    width: currentPage == index ? 16 : 10,
                                    height: currentPage == index ? 10 : 10,
                                    decoration: BoxDecoration(
                                      color: currentPage == index ? Constants.secondaryOrangeColor : Colors.transparent,
                                      border: Border.all(
                                        color: currentPage == index ? Colors.transparent : Colors.grey,
                                      ),
                                      borderRadius: currentPage == index ? BorderRadius.circular(8) : BorderRadius.circular(50),
                                    ),
                                  ),
                                );
                              }),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              screenData['title'],
                              style: TextStyle(fontSize: 18.sp),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  screenData['subtitle'],
                                  style: TextStyle(color: Color(0xffB2B5BD), fontWeight: FontWeight.w400, fontSize: 13.sp),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      if (currentPage == screens.length - 1) {
                        Navigator.pushNamed(context, RoutesNames.loginView);
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 70.0,
                          height: 70.0,
                          child: CustomPaint(
                            painter: RoundedSquarePainter(progress: (currentPage + 1) / 4),
                          ),
                        ),
                        Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 30.0,
                            ),
                          ),
                        ),
                      ],
                    )),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}

class RoundedSquarePainter extends CustomPainter {
  final double progress;
  final double cornerRadius = 16.0;

  RoundedSquarePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paintBackground = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final paintForeground = Paint()
      ..color = Colors.teal
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(cornerRadius));

    canvas.drawRRect(rrect, paintBackground);

    final path = Path()..addRRect(rrect);
    final pathMetric = path.computeMetrics().first;
    final extractPath = pathMetric.extractPath(0, pathMetric.length * progress);
    canvas.drawPath(extractPath, paintForeground);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
