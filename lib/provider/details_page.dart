// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:zeelpay/provider/beneficiary_provider.dart';
// import 'package:zeelpay/provider/selection_screen.dart';

// class BankDetailsPage extends StatefulWidget {
//   const BankDetailsPage({super.key});

//   @override
//   _BankDetailsPageState createState() => _BankDetailsPageState();
// }

// class _BankDetailsPageState extends State<BankDetailsPage> {
//   Beneficiary? _selectedBeneficiary;

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => BeneficiaryProvider(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Bank Details'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               ElevatedButton(
//                 onPressed: () async {
//                   final selectedBeneficiary = await Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => BeneficiarySelectionScreen(
//                         beneficiaries:
//                             context.read<BeneficiaryProvider>().beneficiaries,
//                       ),
//                     ),
//                   );

//                   if (selectedBeneficiary != null) {
//                     setState(() {
//                       _selectedBeneficiary = selectedBeneficiary;
//                     });
//                   }
//                 },
//                 child: const Text('Choose Beneficiary'),
//               ),
//               const SizedBox(height: 16.0),
//               if (_selectedBeneficiary != null) ...[
//                 TextFormField(
//                   initialValue: _selectedBeneficiary!.accountNumber,
//                   decoration:
//                       const InputDecoration(labelText: 'Account Number'),
//                   readOnly: true,
//                 ),
//                 TextFormField(
//                   initialValue: _selectedBeneficiary!.bankName,
//                   decoration: const InputDecoration(labelText: 'Bank Name'),
//                   readOnly: true,
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class BeneficiaryProvider with ChangeNotifier {
//   final List<Beneficiary> _beneficiaries = [
//     Beneficiary(
//         name: "John Doe", accountNumber: "123456789", bankName: "Bank A"),
//     Beneficiary(
//         name: "Jane Smith", accountNumber: "987654321", bankName: "Bank B"),
//   ];

//   List<Beneficiary> get beneficiaries => _beneficiaries;
// }
