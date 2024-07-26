import 'package:flutter/material.dart';
import 'package:zeelpay/constants/svg.dart';
import 'package:zeelpay/screens/user/bills/airtime.dart';
import 'package:zeelpay/screens/user/bills/betting.dart';
import 'package:zeelpay/screens/user/bills/data.dart';
import 'package:zeelpay/screens/user/bills/tv.dart';
import 'package:zeelpay/screens/user/fund/fund_options.dart';
import 'package:zeelpay/screens/user/more/account_level/tier-2/kyc.dart';
import 'package:zeelpay/screens/user/notifications/notification.dart';
import 'package:zeelpay/screens/user/send/amount_screen.dart';
import 'package:zeelpay/screens/user/transaction/history.dart';
import 'package:zeelpay/screens/user/widgets/action_button.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage: AssetImage(
                                            'assets/images/image.png'),
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
                                  GestureDetector(
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
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'My Balance',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '₦300,000.00',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // icon to show the balance
                                  Icon(
                                    Icons.visibility_off,
                                    color: Colors.white,
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
                    _buildKYC(context),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 3.5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Activity',
                                    style: TextStyle(
                                      color: Color(0xff20013A),
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
                                        const Text(
                                          'View all',
                                          style: TextStyle(
                                            color: Color(0xff20013A),
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
                                            color: const Color(0xff20013A),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: const Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.white,
                                              size: 10),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Expanded(
                                child: Center(child: Text("No activity Yet!")),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              )
            ]),
      ),
    );
  }

  _buildKYC(BuildContext context) {
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
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Wrap(
                children: [
                  Text(
                    "Complete KYC",
                    style: TextStyle(
                      color: Color.fromRGBO(156, 38, 49, 1),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                      softWrap: true,
                      "Submitting your KYC will help you enjoy more access to Zeelpay’s")
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_outlined),
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
