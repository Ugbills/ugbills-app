import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ugbills/constants/assets/png.dart';
import 'package:ugbills/constants/assets/svg.dart';
import 'package:ugbills/providers/user_provider.dart';
import 'package:ugbills/screens/user/home/transaction/history.dart';
import 'package:ugbills/screens/user/home/transaction/widgets/transaction_history_widget.dart';
import 'package:ugbills/screens/user/more/account_level/tier-2/kyc.dart';
import 'package:ugbills/screens/user/pay/airtime/airtime.dart';
import 'package:ugbills/screens/user/pay/data/data.dart';
import 'package:ugbills/screens/user/pay/data/internet_data.dart';
import 'package:ugbills/screens/user/pay/data/sme_data.dart';
import 'package:ugbills/screens/user/pay/electricity/electricity.dart';
import 'package:ugbills/screens/user/pay/fund/fund_options.dart';
import 'package:ugbills/screens/user/pay/send/amount_screen.dart';
import 'package:ugbills/screens/user/pay/send/bank/bank.dart';
import 'package:ugbills/screens/user/pay/send/username/by_username.dart';
import 'package:ugbills/screens/user/pay/tv/tv.dart';
import 'package:ugbills/screens/user/widgets/action_button.dart';
import 'package:ugbills/themes/palette.dart';

class DashBoardScreen extends ConsumerStatefulWidget {
  const DashBoardScreen({super.key});

  @override
  ConsumerState<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends ConsumerState<DashBoardScreen> {
  bool stealthMode = false;

  String formatCurrency(dynamic amount) {
    if (amount == null) return '₦0.00';

    // Handle both string and numeric values
    double value = 0.0;
    if (amount is String) {
      value = double.tryParse(amount) ?? 0.0;
    } else if (amount is num) {
      value = amount.toDouble();
    }

    // Format with commas
    final formatted = value.toStringAsFixed(2);
    final parts = formatted.split('.');
    final whole = parts[0].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    );

    return '₦$whole.${parts[1]}';
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? ZealPalette.scaffoldBlack : null,
      body: RefreshIndicator(
          onRefresh: () async {
            ref.refresh(fetchMobileUserInformationProvider);
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Balance card section with background image
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xff1C41AB),
                        image: DecorationImage(
                          opacity: 0.22,
                          image: AssetImage(ZeelPng.backgroundImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Wallet Balance",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[200],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Consumer(
                                    builder: (context, ref, child) {
                                      final userAsyncValue = ref.watch(
                                          fetchMobileUserInformationProvider);

                                      return userAsyncValue.when(
                                        data: (userModel) {
                                          final walletBalance =
                                              userModel?.data?.walletBalance ??
                                                  0;
                                          final displayBalance = stealthMode
                                              ? "₦****"
                                              : formatCurrency(walletBalance);

                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                displayBalance,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                        loading: () => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              stealthMode
                                                  ? "₦****"
                                                  : "Loading...",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        error: (error, stackTrace) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              stealthMode ? "₦****" : "₦0.00",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      stealthMode = !stealthMode;
                                    });
                                  },
                                  child: ShadImage(
                                    stealthMode
                                        ? ZeelSvg.eye
                                        : ZeelSvg.eyeSlash,
                                    color: Colors.white,
                                    width: 25,
                                    height: 25,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Go.to(const FundOptions());
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      height: 60,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: ShadTheme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        color: isDark
                                            ? ZealPalette.darkModeSend
                                            : Colors.white,
                                      ),
                                      child: Center(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Fund Wallet",
                                            style: TextStyle(
                                              color: ShadTheme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      )),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                          isDismissible: true,
                                          useSafeArea: true,
                                          context: context,
                                          builder: (context) => Container(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border(
                                                        top: BorderSide(
                                                            width: 0.5,
                                                            color: ShadTheme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary))),
                                                child: Wrap(
                                                  children: [
                                                    ListTile(
                                                      onTap: () => Go.to(
                                                          const AmountScreen(
                                                        page: SendByUsername(),
                                                      )),
                                                      subtitle: const Text(
                                                          "Send money from your wallet to another UgBills user for free"),
                                                      title: Text(
                                                          "UgBills User",
                                                          style: ShadTheme.of(
                                                                  context)
                                                              .textTheme
                                                              .small
                                                              .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 20,
                                                              )),
                                                    ),
                                                    const Divider(),
                                                    ListTile(
                                                      onTap: () =>
                                                          Go.to(AmountScreen(
                                                        page: BankTransfer(),
                                                      )),
                                                      subtitle: const Text(
                                                          "Send money from UgBills to local banks"),
                                                      title: Text(
                                                          "Bank Account",
                                                          style: ShadTheme.of(
                                                                  context)
                                                              .textTheme
                                                              .small
                                                              .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 20,
                                                              )),
                                                    ),
                                                  ],
                                                ),
                                              ));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      height: 60,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: ShadTheme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        color: isDark
                                            ? ZealPalette.darkModeSend
                                            : Colors.white,
                                      ),
                                      child: Center(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Transfer",
                                            style: TextStyle(
                                              color: ShadTheme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      )),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Go.to(AmountScreen(
                                        page: BankTransfer(),
                                      ));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      height: 60,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: ShadTheme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        color: isDark
                                            ? ZealPalette.darkModeSend
                                            : Colors.white,
                                      ),
                                      child: Center(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Withdraw",
                                            style: TextStyle(
                                              color: ShadTheme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      )),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            _buildPendingKYC(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Quick Services",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Text("All Services",
                          style: TextStyle(
                              color: ShadTheme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 10.0, bottom: 20),
                  child: Wrap(
                    spacing: 25,
                    runSpacing: 10,
                    children: _buildMenuItems(context),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                      height: 100.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      viewportFraction: 1,
                    ),
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        Image.network(
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fitWidth,
                            height: 100,
                            "https://codelist.cc/uploads/posts/2024-10/1729777320_lernen-lms-learning-management-system.jpg"),
                  ),
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
                            'Transaction History',
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white
                                  : const Color(0xff1C41AB),
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
                                        : ShadTheme.of(context)
                                            .colorScheme
                                            .primary,
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
                                        ? ZealPalette.lightestBlue
                                        : ShadTheme.of(context)
                                            .colorScheme
                                            .primary,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: isDark
                                        ? ZealPalette.lightBlue
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
                          limit: 5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          )),
    );
  }

  _buildPendingKYC() {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24).copyWith(bottom: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
        ),
        color: ZealPalette.primaryBlue,
        borderRadius: BorderRadius.circular(10),
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
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  softWrap: true,
                  "Your Kyc request is being reviewed and you will be notified shortly...",
                  style: TextStyle(
                    fontSize: 10,
                    color: isDark ? Colors.white : Colors.white,
                  ),
                )
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_outlined,
            color: Colors.white,
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
                    "Submitting your KYC will help you enjoy more access to UgBills’s",
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
      onTap: () => Go.to(const AirtimeBills()),
      child: ZeelActionButton(
        text: "Airtime",
        icon: ZeelSvg.contact,
        color: isDark ? ZealPalette.darkModeFund : ZealPalette.lightBlue,
      ),
    ),
    GestureDetector(
      onTap: () {
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
                        onTap: () {
                          Navigator.pop(context);
                          Go.to(const DataBills());
                        },
                        subtitle:
                            const Text("Purchase data bundles with cashback"),
                        title: Text("Data Bundle",
                            style:
                                ShadTheme.of(context).textTheme.small.copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 20,
                                    )),
                      ),
                      const Divider(),
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          Go.to(const SMEDataBills());
                        },
                        subtitle: const Text("Purchase SME data plans"),
                        title: Text("SME Data",
                            style:
                                ShadTheme.of(context).textTheme.small.copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 20,
                                    )),
                      ),
                      const Divider(),
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          Go.to(const InternetDataBills());
                        },
                        subtitle: const Text("Purchase internet data plans"),
                        title: Text("Internet Data",
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
        text: "Data",
        icon: ZeelSvg.wifi,
        color: isDark ? ZealPalette.darkModeSend : ZealPalette.lightBlue,
      ),
    ),
    GestureDetector(
      onTap: () => Go.to(const ElectricityBills()),
      child: ZeelActionButton(
        text: "Electricity",
        icon: ZeelSvg.power,
        color: isDark ? ZealPalette.darkModeTV : ZealPalette.lightBlue,
      ),
    ),
    GestureDetector(
      onTap: () => Go.to(const TVBills()),
      child: ZeelActionButton(
        text: "Cable",
        icon: ZeelSvg.cables,
        color: isDark ? ZealPalette.darkModeTV : ZealPalette.lightBlue,
      ),
    ),
  ];
}

// Route _createRoute(Widget child) {
//   return PageRouteBuilder(
//     transitionDuration: const Duration(milliseconds: 300),
//     reverseTransitionDuration: const Duration(milliseconds: 300),
//     pageBuilder: (context, animation, secondaryAnimation) => child,
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(0.0, 1.0);
//       const end = Offset.zero;
//       const curve = Curves.ease;
//       final tween =
//           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//       final offsetAnimation = animation.drive(tween);

//       return SlideTransition(
//         position: offsetAnimation,
//         child: child,
//       );
//     },
//   );
// }



                                    // Row(
                                    //   children: [
                                    //     Container(
                                    //       margin:
                                    //           const EdgeInsets.only(top: 10),
                                    //       padding: const EdgeInsets.symmetric(
                                    //           horizontal: 8, vertical: 4),
                                    //       decoration: const BoxDecoration(
                                    //         color: Color.fromARGB(
                                    //             255, 255, 230, 230),
                                    //         borderRadius: BorderRadius.all(
                                    //             Radius.circular(20)),
                                    //       ),
                                    //       child: const Text(
                                    //         "Daily Limit: ₦500,000",
                                    //         style: TextStyle(
                                    //           color: Colors.red,
                                    //           fontWeight: FontWeight.bold,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),