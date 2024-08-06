// import 'package:flutter/material.dart';
// import 'package:zeelpay/provider/beneficiary_provider.dart';

// class BeneficiarySelectionScreen extends StatelessWidget {
//   final List<Beneficiary> beneficiaries;

//   const BeneficiarySelectionScreen({super.key, required this.beneficiaries});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Select Beneficiary'),
//       ),
//       body: ListView.builder(
//         itemCount: beneficiaries.length,
//         itemBuilder: (context, index) {
//           final beneficiary = beneficiaries[index];
//           return ListTile(
//             title: Text(beneficiary.name),
//             subtitle: Text(beneficiary.bankName),
//             onTap: () {
//               Navigator.pop(context, beneficiary);
//             },
//           );
//         },
//       ),
//     );
//   }
// }
