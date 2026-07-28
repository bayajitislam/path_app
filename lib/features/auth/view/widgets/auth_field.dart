import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/routes/routes_name.dart';

class AuthField extends StatefulWidget {
  final TextEditingController? controller;
  final String lebel;
  final String hintText;
  final bool isPassword;
  final bool isObscure;
  final bool isForgotPassword;
  // final IconData prefixIcon;
  const AuthField({
    super.key,
    required this.lebel,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    // required this.prefixIcon,
    this.isObscure = false,
    this.isForgotPassword = false,
  });

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  late bool isObscure;

  @override
  void initState() {
    super.initState();
    isObscure = widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Label
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.lebel, style: Theme.of(context).textTheme.bodyMedium),

            //only sign in screen
            widget.isForgotPassword
                ? GestureDetector(
                    onTap: () => Get.toNamed(RoutesName.forgotPassword),
                    child: Text(
                      'Forgot Password?',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppPallete.primary,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),

        //Field
        SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            color: AppPallete.secondary,
            boxShadow: [
              BoxShadow(
                blurStyle: BlurStyle.inner,
                color: AppPallete.secondaryText.withValues(alpha: 0.1),
                blurRadius: 24,
                spreadRadius: 1,
              ),
            ],
            borderRadius: BorderRadius.circular(6),
          ),
          child: TextFormField(
            controller: widget.controller,
            style: TextStyle(color: AppPallete.primaryText),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(color: AppPallete.secondaryText),

              // prefixIcon: Icon(widget.prefixIcon, size: 20),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      icon: isObscure
                          ? Icon(Icons.visibility_off, size: 20)
                          : Icon(Icons.visibility, size: 20),
                    )
                  : null,
            ),
            obscureText: isObscure,
          ),
        ),
      ],
    );
  }
}
