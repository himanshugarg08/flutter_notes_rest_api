import 'dart:ui';

const primaryColor = Color(0xffffa447);
const secondaryColor = Color(0xffF2F5FA);
const kDarkColor = Color(0xff2E3142);
const kLightColor = Color(0xffffffff);

const colorsList = [
  Color(0xffffa447),
  Color(0xff7ecbff),
  Color(0xffffa6c4),
  Color(0xff1eccc3),
  Color(0xffffa3a3)
];

const Map<int, String> monthsInYear = {
  1: "Jan",
  2: "Feb",
  3: "Mar",
  4: "Apr",
  5: "May",
  6: "Jun",
  7: "Jul",
  8: "Aug",
  9: "Sep",
  10: "Oct",
  11: "Nov",
  12: "Dec",
};

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
