import 'dart:developer';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:zeelpay/constants/assets/svg.dart';
import 'package:zeelpay/helpers/common/amount_formatter.dart';
import 'package:zeelpay/providers/transaction_provider.dart';
import 'package:zeelpay/providers/user_provider.dart';
import 'package:zeelpay/screens/user/home/notifications/notification.dart';
import 'package:zeelpay/screens/user/home/transaction/history.dart';
import 'package:zeelpay/screens/user/home/transaction/widgets/transaction_history_widget.dart';
import 'package:zeelpay/screens/user/more/account_level/tier-2/kyc.dart';
import 'package:zeelpay/screens/user/pay/airtime/airtime.dart';
import 'package:zeelpay/screens/user/pay/betting/betting.dart';
import 'package:zeelpay/screens/user/pay/data/data.dart';
import 'package:zeelpay/screens/user/pay/fund/fund_options.dart';
import 'package:zeelpay/screens/user/pay/send/amount_screen.dart';
import 'package:zeelpay/screens/user/pay/send/bank/bank.dart';
import 'package:zeelpay/screens/user/pay/send/username/by_username.dart';
import 'package:zeelpay/screens/user/pay/tv/tv.dart';
import 'package:zeelpay/screens/user/widgets/action_button.dart';
import 'package:zeelpay/themes/palette.dart';

class DashBoardScreen extends ConsumerStatefulWidget {
  const DashBoardScreen({super.key});

  @override
  ConsumerState<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends ConsumerState<DashBoardScreen> {
  bool stealthMode = false;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    var user = ref.watch(fetchUserInformationProvider);
    return Scaffold(
      backgroundColor: isDark ? ZealPalette.scaffoldBlack : null,
      body: RefreshIndicator(
        onRefresh: () async {
          log("refreshing");
          ref.refresh(fetchUserInformationProvider);
          ref.refresh(fetchUserTransactionsProvider());
        },
        child: CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: user.when(
                          data: (data) => null,
                          error: (e, s) =>
                              MediaQuery.of(context).size.height / 4,
                          loading: () =>
                              MediaQuery.of(context).size.height / 4),
                      padding: const EdgeInsets.only(bottom: 20),
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
                        child: user.when(
                            data: (userinfo) => Column(
                                  children: [
                                    const SizedBox(height: 12),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 30,
                                                backgroundImage: userinfo!.data!
                                                        .profilePicture!.isEmpty
                                                    ? const AssetImage(
                                                        'assets/images/image.png')
                                                    : NetworkImage(userinfo
                                                        .data!.profilePicture!),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Hi, ${userinfo.data!.firstName!.capitalize} 👋",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                  const Text(
                                                    'Welcome back!',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
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
                                              backgroundColor:
                                                  Color(0xff4D3461),
                                              child: Icon(
                                                Icons
                                                    .notifications_none_outlined,
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
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
                                                      : '₦${returnAmount(userinfo.data!.walletBalance!)}',
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
                                        ))
                                    // ),
                                    // Expanded(
                                    //   child: Align(
                                    //     alignment: Alignment.bottomCenter,
                                    //     child: Container(
                                    //       width:
                                    //           MediaQuery.of(context).size.width,
                                    //       decoration: const BoxDecoration(
                                    //         color: Colors.black,
                                    //         borderRadius: BorderRadius.only(
                                    //           bottomLeft: Radius.circular(30),
                                    //           bottomRight: Radius.circular(30),
                                    //         ),
                                    //       ),
                                    //       child: const Padding(
                                    //         padding: EdgeInsets.all(20.0),
                                    //         child: Center(
                                    //             child: Text(
                                    //           "USDT - \$1/₦1,000 BTC - \$42,000/₦42,000,000 ETH - \$3,500/₦3,500,000",
                                    //           overflow: TextOverflow.ellipsis,
                                    //           style: TextStyle(
                                    //               color: Colors.white,
                                    //               fontSize: 13,
                                    //               fontWeight: FontWeight.bold),
                                    //         )),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                ),
                            loading: () => const Center(
                                child: CircularProgressIndicator()),
                            error: (error, stackTrace) =>
                                Text(error.toString())),
                      ),
                    ),
                    user.when(
                        data: (user) {
                          return user!.data!.kycVerified!
                              ? const SizedBox.shrink()
                              : user.data!.kycSubmitted!
                                  ? _buildPendingKYC()
                                  : _buildKYC();
                        },
                        error: (error, stack) => const SizedBox.shrink(),
                        loading: () => const SizedBox.shrink()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3,
                      decoration: BoxDecoration(
                        color: isDark ? ZealPalette.lighterBlack : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
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
                          const Expanded(
                            child: TransactionHistoryWidget(
                              limit: 3,
                            ),
                          ),
                        ],
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

  _buildPendingKYC() {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
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
                  "KYC Pending",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(156, 38, 49, 1),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  softWrap: true,
                  "Your Kyc request is being reviewed and you will be notified shortly...",
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
            color: isDark ? const Color.fromRGBO(156, 38, 49, 1) : Colors.grey,
          ),
        ],
      ),
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
  bool isDark = Theme.of(context).brightness == Brightness.dark;
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
      child: ZeelActionButton(
        text: "Fund",
        icon: ZeelSvg.fund,
        color: isDark ? ZealPalette.darkModeFund : const Color(0xffFFC9CE),
      ),
    ),
    GestureDetector(
      onTap: () {
        //open bottomsheet with listview where user select username ot Bank
        showModalBottomSheet(
            isDismissible: true,
            useSafeArea: true,
            context: context,
            builder: (context) => Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border(
                          top: BorderSide(
                              width: 0.5,
                              color:
                                  ShadTheme.of(context).colorScheme.primary))),
                  child: Wrap(
                    children: [
                      ListTile(
                        onTap: () => Go.to(const AmountScreen(
                          page: SendByUsername(),
                        )),
                        subtitle: const Text(
                            "Send money from your wallet to another Zeelpay user for free"),
                        title: Text("ZeelPay User",
                            style:
                                ShadTheme.of(context).textTheme.small.copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 20,
                                    )),
                      ),
                      const Divider(),
                      ListTile(
                        onTap: () => Go.to(AmountScreen(
                          page: BankTransfer(),
                        )),
                        subtitle: const Text(
                            "Send money from Zeelpay to local banks"),
                        title: Text("Bank Account",
                            style:
                                ShadTheme.of(context).textTheme.small.copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 20,
                                    )),
                      ),
                    ],
                  ),
                ));
      },
      child: ZeelActionButton(
        text: "Send",
        icon: ZeelSvg.send,
        color: isDark ? ZealPalette.darkModeSend : const Color(0xffFFD3B3),
      ),
    ),
    GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TVBills(),
        ),
      ),
      child: ZeelActionButton(
        text: "TV",
        icon: ZeelSvg.tv,
        color: isDark ? ZealPalette.darkModeTV : const Color(0xffCFC6FF),
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
      child: ZeelActionButton(
        text: "Buy Data",
        icon: ZeelSvg.data,
        color: isDark ? ZealPalette.darkModeData : const Color(0xffFED4FF),
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
      child: ZeelActionButton(
        text: "Buy Airtime",
        icon: ZeelSvg.airtime,
        color: isDark ? ZealPalette.darkModeAirtime : const Color(0xffB6E1FF),
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
      child: ZeelActionButton(
        text: "Betting",
        icon: ZeelSvg.betting,
        color: isDark ? ZealPalette.darkModeBetting : const Color(0xffAEFFCF),
      ),
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
