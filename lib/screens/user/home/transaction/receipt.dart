import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/helpers/common/amount_formatter.dart';
import 'package:zeelpay/helpers/common/data_formatter.dart';
import 'package:zeelpay/models/api/transactions_model.dart';
import 'package:zeelpay/themes/palette.dart';

buildReciept({required ResponseData transaction}) => Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                const EdgeInsets.only(right: 30, left: 30, top: 50, bottom: 10),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: ZealPalette.primaryPurple,
              image: DecorationImage(
                image: AssetImage("assets/images/bcc.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShadImage(
                      "assets/images/zeel.png",
                      height: 25,
                      width: 105,
                    ),
                    Text(
                      "TRANSACTION RECIEPT",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Amount",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    "₦${returnAmount(transaction.amount)}",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text("Beneficiary"),
                    ),
                    Expanded(
                      child: Text(
                        transaction.recipient!,
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.clip,
                      ),
                    )
                  ],
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                transaction.method!.toLowerCase() == "transfer"
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Text("Beneficiary Account"),
                              ),
                              Expanded(
                                child: Text(
                                  transaction.accountNumber!,
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.clip,
                                ),
                              )
                            ],
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Text("Beneficiary Bank"),
                              ),
                              Expanded(
                                child: Text(
                                  transaction.bank!,
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.clip,
                                ),
                              )
                            ],
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text("Fee"),
                    ),
                    Expanded(
                      child: Text(
                        "₦${returnAmount(transaction.fee!)}",
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.clip,
                      ),
                    )
                  ],
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text("Naration"),
                    ),
                    Expanded(
                      child: Text(
                        transaction.note!,
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.clip,
                      ),
                    )
                  ],
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text("Date"),
                    ),
                    Expanded(
                      child: Text(
                        formartDate(transaction.createdAt!),
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.clip,
                      ),
                    )
                  ],
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text("Reference"),
                    ),
                    Expanded(
                      child: Text(
                        transaction.reference!,
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.clip,
                      ),
                    )
                  ],
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text("Transaction ID"),
                    ),
                    Expanded(
                      child: Text(
                        transaction.transactionId!,
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.clip,
                      ),
                    )
                  ],
                ),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text("Status"),
                    ),
                    Expanded(
                      child: Text(
                        transaction.status!,
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.clip,
                      ),
                    )
                  ],
                ),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Issue with this transaction?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                    "If you have any questions, contact ZeelPay Technologies Limited at support@zeelpay.com or call at +2348142364195"),
              ],
            ),
          ),
        ],
      ),
    );
