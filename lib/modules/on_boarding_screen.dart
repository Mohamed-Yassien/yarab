import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../models/board_model.dart';
import '../network/local/cache_helper.dart';
import '../shared/methods.dart';
import 'login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  bool isLast = false;

  List<BoardModel> boardItems = [
    BoardModel(
      image: 'assets/images/board1.png',
      title: 'OnBoardTitle 1',
      body: 'OnBoardBody 1',
    ),
    BoardModel(
      image: 'assets/images/board2.png',
      title: 'OnBoardTitle 2',
      body: 'OnBoardBody 2',
    ),
    BoardModel(
      image: 'assets/images/board3.jpg',
      title: 'OnBoardTitle 3',
      body: 'OnBoardBody 3',
    ),
  ];

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then(
      (value) {
        navigateToAndFinish(widget: LoginScreen(), context: context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: submit,
            child: const Text(
              'SKIP',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  if (index == boardItems.length - 1) {
                    setState(
                      () {
                        isLast = true;
                      },
                    );
                  } else {
                    setState(
                      () {
                        isLast = false;
                      },
                    );
                  }
                },
                controller: boardController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildOnBoardItem(
                  boardItems[index],
                ),
                itemCount: 3,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boardItems.length,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Colors.deepOrange,
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 7,
                    expansionFactor: 3,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                       submit();
                    } else {
                      boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 700,
                        ),
                        curve: Curves.easeInToLinear,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildOnBoardItem(BoardModel model) {
  return Column(
    children: [
      Expanded(
        child: Image.asset(
          model.image,
        ),
      ),
      Text(
        model.title,
        style: const TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        model.body,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 100,
      ),
    ],
  );
}
