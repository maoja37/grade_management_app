// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class CustomNavigationBar extends StatefulWidget {
//   const CustomNavigationBar({super.key});

//   @override
//   State<CustomNavigationBar> createState() => _CustomNavigationBarState();
// }

// class _CustomNavigationBarState extends State<CustomNavigationBar> {
//   int currentIndex = 0;
//   static const navBarItemsString = <String>[
//     'Home',
//     'Savings',
//     'Loans',
//     'Accounts',
//     'Card',
//   ];
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     return Container(
//       height: 77,
//       decoration: BoxDecoration(
//         color: const Color(0xff1B1C19),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.15),
//             blurRadius: 8,
//             offset: const Offset(0, -2),
//           ),
//         ],
//       ),
//       child: ListView.builder(
//         itemCount: 2,
//         scrollDirection: Axis.horizontal,
//         padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
//         itemBuilder: (context, index) => InkWell(
//           onTap: () {
//             setState(() {
//               currentIndex = index;
//               HapticFeedback.lightImpact();
//             });
//           },
//           splashColor: Colors.transparent,
//           highlightColor: Colors.transparent,
//           child: Stack(
//             children: [
//               Row(
//                 children: [
//                   AnimatedContainer(
//                     duration: const Duration(milliseconds: 400),
//                     curve: Curves.fastLinearToSlowEaseIn,
//                     width: index == currentIndex
//                         ? spaceBetweenContainerXText(index, context)
//                         : 0,
//                   ),
//                   AnimatedOpacity(
//                     opacity: index == currentIndex ? 1 : 0,
//                     duration: const Duration(milliseconds: 400),
//                     curve: Curves.fastLinearToSlowEaseIn,
//                     child: Text(
//                       index == currentIndex ? navBarItemsString[index] : '',
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w400,
//                         color: index == currentIndex
//                             ? const Color(0xff122D97)
//                             : Colors.transparent,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   AnimatedContainer(
//                     duration: const Duration(milliseconds: 400),
//                     curve: Curves.fastLinearToSlowEaseIn,
//                     width: index == currentIndex
//                         ? spaceBetweenContainerXIcon(index, context)
//                         : spaceForUnselectedIcons(index, context),
//                   ),
//                   index == currentIndex
//                       ? AppImages.bottomNavBoldIcons[index]
//                       : AppImages.bottomNavLightIcons[index],
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
