import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Colors
const backgroundColor = Colors.black;
const kWhiteColor = Colors.white;
const kBlackColor = Colors.black;
const infoBack = Color(0x47979797);
const kGrey = Color.fromARGB(255, 53, 53, 53);
const kGrey1 = Color.fromARGB(255, 40, 33, 33);

const kGreen = Color(0xFF71BC7E);
const kYellow = Color(0xFFDDD471);
const kOrange = Color(0xFFFEA384);
const kRed = Colors.red;

// Text Styles
final TextStyle jStyleW = GoogleFonts.jost(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);

final TextStyle joffwh = GoogleFonts.jost(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: Colors.white70,
);

final TextStyle j30 = GoogleFonts.jost(
  fontSize: 30,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);

final TextStyle j24 = GoogleFonts.jost(
  fontSize: 24,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);

final TextStyle j20 = GoogleFonts.jost(
  fontSize: 20,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);

final TextStyle j20G = GoogleFonts.jost(
  fontSize: 20,
  fontWeight: FontWeight.w500,
  color: kGreen,
);

final TextStyle jStyleB = GoogleFonts.jost(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);

final TextStyle jStyleHint = GoogleFonts.jost(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  color: Colors.grey,
);

// Border radius
BorderRadius kradius10 = BorderRadius.circular(10);
BorderRadius kradius30 = BorderRadius.circular(30);
BorderRadius kradius20 = BorderRadius.circular(20.0);
BorderRadius kradius100 = BorderRadius.circular(100);

// Auth key shared preferences
const authKey = 'UserLoggedIn';

// Token key shared preferences
const tokenKey = 'userToken';

// User ID key shared preferences
const userIdKey = 'userId';

// User Role key shared preferences
const userRolekey = 'userRole';

// User Email key shared preferences
const userEmailkey = 'userEmail';

// User Name key shared preferences
const userNamekey = 'userName';

// User Profile Pic key shared preferences
const userProfilePickey = 'userProfilePic';
