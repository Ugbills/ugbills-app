import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:zeelpay/constants/png.dart';
import 'package:zeelpay/screens/account_screen.dart';
import 'package:zeelpay/themes/palette.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final controller = PageController(viewportFraction: 1, keepPage: true);

  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: pages[currentIndex].color,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (currentIndex == pages.length - 1)
                ? const SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ShadButton.link(
                        text: const Text('Skip',
                            style: TextStyle(
                                color: ZealPalette.primaryPurple,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          controller.animateToPage(
                            pages.length - 1,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        },
                      )
                    ],
                  ),
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        pages[index].image,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        pages[index].title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          textAlign: TextAlign.center,
                          pages[index].description,
                          style: const TextStyle(
                            color: Color.fromRGBO(69, 69, 69, 1),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SmoothPageIndicator(
                controller: controller, // PageController
                count: pages.length,
                effect: const WormEffect(
                    activeDotColor: ZealPalette.primaryPurple,
                    dotHeight: 10,
                    dotWidth: 10), // your preferred effect
                onDotClicked: (index) {
                  controller.animateToPage(index,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut);
                }),
            const SizedBox(height: 30),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ZeelButton(
                  text: (currentIndex == pages.length - 1)
                      ? "Get Started"
                      : "Next",
                  onPressed: () {
                    if (currentIndex == pages.length - 1) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AccountScreen()));
                    } else {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class Shadtheme {}

List<OnboardingPage> pages = [
  OnboardingPage(
      "Effortless Bill Payments",
      "Pay your bills conveniently from the comfort of your home or on the go.",
      ZeelPng.bills,
      const Color(0xffFFF4E6)),
  OnboardingPage(
      "Top Up on the Go",
      "Never run out of data or airtime again. Top up your mobile plan or purchase airtime for others with just a few taps.",
      ZeelPng.topUp,
      const Color(0xffF2ECFF)),
  OnboardingPage(
      "Swap Airtime with Ease",
      "Have excess airtime? Convert it into cash or exchange it with others securely through our airtime swap feature.",
      ZeelPng.swap,
      const Color(0xffF6FFF5)),
  OnboardingPage(
      "Gift Card",
      "Browse and purchase gift cards from popular brands like Netflix, Google Play, Amazon, and more.",
      ZeelPng.giftCard,
      const Color(0xffF0F2FF)),
  OnboardingPage(
      "Trade Crypto",
      "Buy and sell your cryptocurrency investments seamlessly.",
      ZeelPng.tradeCrypto,
      const Color(0xffFFFCF0)),
];

class OnboardingPage {
  final String title;
  final String description;
  final String image;
  final Color color;

  OnboardingPage(this.title, this.description, this.image, this.color);
}

class ZeelButton extends StatelessWidget {
  final Function()? onPressed;
  final String? text;
  final Color color;
  final bool borderColor;

  const ZeelButton({
    super.key,
    this.onPressed,
    this.text = "Log in",
    this.color = const Color(0xff20013A),
    this.borderColor = false,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      width: double.infinity,
      height: 57.0,
      child: FilledButton(
        style: FilledButton.styleFrom(
            side: BorderSide(
              color: isDark && borderColor
                  ? ZealPalette.lightPurple
                  : const Color(0xff20013A),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            backgroundColor: color),
        onPressed: onPressed,
        child: Text(
          text!,
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: isDark
                  ? Colors.grey.shade200
                  : borderColor
                      ? const Color(0xff20013A)
                      : Colors.white),
        ),
      ),
    );
  }
}
