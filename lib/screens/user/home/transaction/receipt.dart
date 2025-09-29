import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:ugbills/helpers/common/amount_formatter.dart';
import 'package:ugbills/helpers/common/data_formatter.dart';
import 'package:ugbills/models/api/transactions_model.dart';
import 'package:ugbills/themes/palette.dart';

buildReciept({required Transaction transaction}) => Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                const EdgeInsets.only(right: 30, left: 30, top: 50, bottom: 10),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: ZealPalette.primaryBlue,
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
                      "assets/images/ug.png",
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
                        transaction.beneficiary ?? "N/A",
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
                transaction.type?.toLowerCase() == "transfer"
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
                                  transaction.beneficiary ?? "N/A",
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
                                child: Text("Product"),
                              ),
                              Expanded(
                                child: Text(
                                  transaction.product?.name ?? "N/A",
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
                        "₦${returnAmount(transaction.amount)}",
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
                      child: Text("Description"),
                    ),
                    Expanded(
                      child: Text(
                        transaction.description ?? "N/A",
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
                        formartDate(transaction.createdAt ?? ""),
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
                        transaction.reference ?? "N/A",
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
                        transaction.id?.toString() ?? "N/A",
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
                        transaction.status ?? "N/A",
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
                    "If you have any questions, contact UgBills Technologies Limited at support@UgBills.com or call at +2348142364195"),
              ],
            ),
          ),
        ],
      ),
    );
