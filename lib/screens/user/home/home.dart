import 'package:flutter/material.dart';
import 'package:zeelpay/constants/png.dart';
import 'package:zeelpay/constants/svg.dart';
import 'package:zeelpay/screens/user/pay/airtime/airtime.dart';
import 'package:zeelpay/screens/user/pay/betting/betting.dart';
import 'package:zeelpay/screens/user/pay/data/data.dart';
import 'package:zeelpay/screens/user/pay/tv/tv.dart';
import 'package:zeelpay/screens/user/pay/fund/fund_options.dart';
import 'package:zeelpay/screens/user/more/account_level/tier-2/kyc.dart';
import 'package:zeelpay/screens/user/home/notifications/notification.dart';
import 'package:zeelpay/screens/user/pay/send/amount_screen.dart';
import 'package:zeelpay/screens/user/home/transaction/history.dart';
import 'package:zeelpay/screens/user/widgets/action_button.dart';
import 'package:zeelpay/themes/palette.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  bool stealthMode = false;
  List activity = [
    ["MTN Airtime", "06:59 PM • 07 Mar", "₦3,000", false],
    ["Bitcoin Trade", "06:59 PM • 07 Mar", "₦15,000", true],
    ["EKEDC 23024343", "06:59 PM • 07 Mar", "₦8,000", true],
    ["GLO Data", "06:59 PM • 07 Mar", "₦5,000", false],
    ["DSTV", "06:59 PM • 07 Mar", "₦13,000", false],
  ];
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? ZealPalette.scaffoldBlack : null,
      body: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      color: Color(0xff20013A),
                      image: DecorationImage(
                        image: AssetImage('assets/images/dashboard_bg.png'),
                        opacity: 1,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: SafeArea(
                      bottom: false,
                      child: Column(
                        children: [
                          const SizedBox(height: 12),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          AssetImage('assets/images/image.png'),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Welcome back!',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          'Omere Kelly',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const Notifications(),
                                    ),
                                  ),
                                  child: const CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Color(0xff4D3461),
                                    child: Icon(
                                      Icons.notifications_none_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'My Balance',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      stealthMode
                                          ? "**********"
                                          : '₦300,000.00',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ],
                                ),
                                // icon to show the balance
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      stealthMode = !stealthMode;
                                    });
                                  },
                                  icon: Icon(
                                    stealthMode
                                        ? Icons.remove_red_eye
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Center(
                                      child: Text(
                                    "USDT - \$1/₦1,000 BTC - \$42,000/₦42,000,000 ETH - \$3,500/₦3,500,000",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  _buildKYC(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0)
                        .copyWith(top: 24),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _buildMenuItems(context).length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          return _buildMenuItems(context)[index];
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30.0),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3.5,
                    decoration: BoxDecoration(
                      color: isDark ? ZealPalette.lighterBlack : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark ? ZealPalette.lighterBlack : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Activity',
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white
                                      : const Color(0xff20013A),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const TransactionHistory(),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'View all',
                                      style: TextStyle(
                                        color: isDark
                                            ? Colors.white
                                            : const Color(0xff20013A),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      height: 20,
                                      width: 20,
                                      padding: const EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                        color: isDark
                                            ? ZealPalette.lightestPurple
                                            : const Color(0xff20013A),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: isDark
                                            ? ZealPalette.lightPurple
                                            : Colors.white,
                                        size: 10,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: activity.length,
                                itemBuilder: (context, index) {
                                  return activityView(index);
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            )
          ]),
    );
  }

  Column activityView(int index) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(ZeelPng.mtn_2, height: 46),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity[index][0],
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        activity[index][1],
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                activity[index][2],
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: activity[index][3]
                      ? ZealPalette.successGreen
                      : ZealPalette.errorRed,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  _buildKYC() {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const KYCVerification(),
            ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(252, 235, 236, 1),
          border: Border.all(
            color: const Color.fromRGBO(156, 38, 49, 1),
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Wrap(
                children: [
                  const Text(
                    "Complete KYC",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(156, 38, 49, 1),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    softWrap: true,
                    "Submitting your KYC will help you enjoy more access to Zeelpay’s",
                    style: TextStyle(
                      fontSize: 10,
                      color: isDark
                          ? const Color.fromRGBO(156, 38, 49, 1)
                          : Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color:
                  isDark ? const Color.fromRGBO(156, 38, 49, 1) : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> _buildMenuItems(BuildContext context) {
  return [
    GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FundOptions(),
          ),
        );
      },
      child: const ZeelActionButton(
        text: "Fund",
        icon: ZeelSvg.fund,
        color: Color(0xffFFC9CE),
      ),
    ),
    GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AmountScreen(),
          ),
        );
      },
      child: const ZeelActionButton(
        text: "Send",
        icon: ZeelSvg.send,
        color: Color(0xffFFD3B3),
      ),
    ),
    GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TVBills(),
        ),
      ),
      child: const ZeelActionButton(
        text: "TV",
        icon: ZeelSvg.tv,
        color: Color(0xffCFC6FF),
      ),
    ),
    GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DataBills(),
          ),
        );
      },
      child: const ZeelActionButton(
        text: "Buy Data",
        icon: ZeelSvg.data,
        color: Color(0xffFED4FF),
      ),
    ),
    GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AirtimeBills(),
          ),
        );
      },
      child: const ZeelActionButton(
        text: "Buy Airtime",
        icon: ZeelSvg.airtime,
        color: Color(0xffB6E1FF),
      ),
    ),
    GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          _createRoute(
            const BettingBills(),
          ),
        );
      },
      child: const ZeelActionButton(
          text: "Betting", icon: ZeelSvg.betting, color: Color(0xffAEFFCF)),
    ),
  ];
}

Route _createRoute(Widget child) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      final tween =
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
