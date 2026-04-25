// import 'package:flutter/material.dart';
// import 'package:nutrilens/core/utils/spacer.dart';
// import 'package:nutrilens/features/auth/presentation/login/presentation/widgets/password_and_email_validations.dart';

// class SignUpValidation extends StatefulWidget {
//   const SignUpValidation({super.key});

//   @override
//   State<SignUpValidation> createState() => _SignUpValidationState();
// }

// class _SignUpValidationState extends State<SignUpValidation> {
//   bool isPassword = false;
//   bool isConfirmPassword = false;
//   bool hasUpperLetter = false;
//   bool hasLowerLetter = false;
//   bool hasANumber = false;
//   bool hasSpecialCharacter = false;
//   bool hasCharacterLength = false;
//   bool hasMatchedPassword = false;
//   // signUp Controllers
//   final TextEditingController userNameController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController signUpEmailController = TextEditingController();
//   final TextEditingController signUpPasswordController =
//       TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     signUpPasswordController.addListener(() {
//       setState(() {
//         hasUpperLetter = PasswordAndEmailValidations.hasUpperLetter(
//           signUpPasswordController.text,
//         );
//         hasLowerLetter = PasswordAndEmailValidations.hasLowerLetter(
//           signUpPasswordController.text,
//         );
//         hasANumber = PasswordAndEmailValidations.hasANumber(
//           signUpPasswordController.text,
//         );
//         hasSpecialCharacter = PasswordAndEmailValidations.hasSpecialCharacter(
//           signUpPasswordController.text,
//         );
//         hasCharacterLength = PasswordAndEmailValidations.hasMinimumLength(
//           signUpPasswordController.text,
//         );
//         hasMatchedPassword = PasswordAndEmailValidations.hasMatchedPassword(
//           signUpPasswordController.text,
//           confirmPasswordController.text,
//         );
//       });
//     });
//     confirmPasswordController.addListener(() {
//       setState(() {
//         hasMatchedPassword = PasswordAndEmailValidations.hasMatchedPassword(
//           signUpPasswordController.text,
//           confirmPasswordController.text,
//         );
//       });
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: formKey,
//       child: Column(
//         children: [
//           CustomTextField(
//             controller: userNameController,
//             validator: (userName) {
//               if (userName!.isEmpty) {
//                 return "Please enter your Name";
//               }
//               return null;
//             },
//             labelText: "Username",
//           ),
//           heightSpace(15),
//           CustomTextField(
//             controller: signUpEmailController,
//             validator: (email) {
//               if (email!.isEmpty) {
//                 return "Please enter your email";
//               }
//               if (!PasswordAndEmailValidations.isValidEmail(email: email)) {
//                 return "Please enter a valid email";
//               }
//               return null;
//             },
//             labelText: "Email",
//           ),
//           heightSpace(15),
//           CustomTextField(
//             controller: phoneController,
//             validator: (phonNumber) {
//               if (phonNumber!.isEmpty) {
//                 return "Please enter your Phone Number";
//               }
//               if (!PasswordAndEmailValidations.hasAValidPhoneNumber(
//                 phonNumber,
//               )) {
//                 return "Please enter a valid Phone Number";
//               }
//               return null;
//             },
//             labelText: "Phone Number",
//           ),
//           heightSpace(15),
//           CustomTextField(
//             controller: signUpPasswordController,
//             validator: (password) {
//               if (password!.isEmpty) {
//                 return "Please enter your password";
//               }
//               if (!PasswordAndEmailValidations.isPasswordValid(password)) {
//                 return "Please enter a valid password";
//               }
//               return null;
//             },
//             isPassword: !isPassword,
//             suffixIcon: IconButton(
//               onPressed: () {
//                 isPassword = !isPassword;
//                 setState(() {});
//               },
//               icon: Icon(
//                 isPassword ? Icons.visibility : Icons.visibility_off,
//                 color: isPassword
//                     ? AppColors.kPrimaryColor
//                     : AppColors.kBorderColor,
//               ),
//             ),
//             labelText: "Password",
//           ),
//           heightSpace(15),
//           CustomTextField(
//             controller: confirmPasswordController,
//             validator: (confirmPassword) {
//               if (confirmPassword!.isEmpty) {
//                 return "Please enter your Confirm Password";
//               }
//               if (!PasswordAndEmailValidations.hasMatchedPassword(
//                 signUpPasswordController.text,
//                 confirmPassword,
//               )) {
//                 return "Please enter a valid Confirm Password";
//               }
//               return null;
//             },
//             isPassword: !isConfirmPassword,
//             suffixIcon: IconButton(
//               onPressed: () {
//                 isConfirmPassword = !isConfirmPassword;
//                 setState(() {});
//               },
//               icon: Icon(
//                 isConfirmPassword ? Icons.visibility : Icons.visibility_off,
//                 color: isConfirmPassword
//                     ? AppColors.kPrimaryColor
//                     : AppColors.kBorderColor,
//               ),
//             ),
//             labelText: "Confirm Password",
//           ),
//           heightSpace(15),
//           PasswordValidation(
//             hasANumber: hasANumber,
//             hasCharacterLength: hasCharacterLength,
//             hasLowerLetter: hasLowerLetter,
//             hasSpecialCharacter: hasSpecialCharacter,
//             hasUpperLetter: hasUpperLetter,
//             isSignUpScreen: true,
//             hasMatchedPassword: hasMatchedPassword,
//           ),
//           heightSpace(33),
//           MyCustomButton(
//             onPressed: () {
//               //     SignUpCubit cubit = getIt<SignUpCubit>();
//               // if (formKey.currentState!.validate()) {
//               //   cubit.signUp(
//               //     userName: userNameController.text,
//               //     email: signUpEmailController.text,
//               //     phone: phoneController.text,
//               //     password: signUpPasswordController.text,
//               //     confirmPassword: confirmPasswordController.text,
//               //   );
//               // }
//             },
//             text: "Create an account",
//           ),
//         ],
//       ),
//     );
//   }
// }
