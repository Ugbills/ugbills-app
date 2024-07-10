import 'package:flutter/material.dart';

class ZeelButton extends StatelessWidget {
  final Function()? onPressed;
  final String? text;

  const ZeelButton({
    super.key,
    this.onPressed,
    this.text = "Log in",
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 57.0,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                backgroundColor: const Color(0xff20013A)),
            onPressed: onPressed,
            child: Text(
              text!,
              style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: Colors.white),
            )));
  }
}

class ZeelAltButton extends StatelessWidget {
  final Function()? onPressed;
  final String? text;

  const ZeelAltButton({
    super.key,
    this.onPressed,
    this.text = "",
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 57.0,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              side: const BorderSide(
                width: 1.0,
                color: Color(0xff20013A),
              ),
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            ),
            onPressed: onPressed,
            child: Text(
              text!,
              style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Color(0xff20013A),
                  fontSize: 16),
            )));
  }
}

class ZeelBackButton extends StatelessWidget {
  final Color? color;
  const ZeelBackButton({
    super.key,
    this.color = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            border: const Border.fromBorderSide(BorderSide(color: Colors.grey)),
          ),
          height: 48,
          width: 48,
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          )),
    );
  }
}
