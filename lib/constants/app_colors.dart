import 'package:flutter/material.dart';

class AppColors {
  // private constructor
  AppColors._();

  static const primary = Color(0xFFD0BFFF);
  static const primaryDark = Color(0xFF5F3DC4);
  static const primaryLight = Color(0xFFF2F0FF);
  static const primaryAccent = Color(0xFFD9D9D9);
  static const backgroundColor = Colors.white;

  // App bar
  static const backgroundColorAppBarLight = Color(0xFFD0BFFF);
  static const backgroundColorAppBarDark = Colors.black;

  // Dialog
  static const dialogBackgroundColorLight = Colors.white;
  static const dialogBackgroundColorDark = Color.fromARGB(255, 49, 49, 49);

  // Scheme color for Buttons, dialog background etc
  static const primarySchemaColorLight = Colors.green;
  static const primarySchemaColorDark = Color(0xFFFF8383);

  static const Map<int, Color> primarySwatch = <int, Color>{
    50: Color(0xFFE5F0F8),
    100: Color(0xFFBFDAEE),
    200: Color(0xFF95C1E2),
    300: Color(0xFF6AA8D6),
    400: Color(0xFF4A95CE),
    500: Color(0xFF2A82C5),
    600: Color(0xFF257ABF),
    700: Color(0xFF1F6FB8),
    800: Color(0xFF1965B0),
    900: Color(0xFF0F52A3)
  };

  static const black = Color(0xFF2E2739);
  static const lightGrey = Color(0xFFF6F6FA);
  static const grey = Color(0xFFDBDBDF);
  static const darkGrey = Color(0xFF827D88);
  static const blue = Color(0xFF61C3F2);

  static const cyan = Color(0xFF15D2BC);
  static const pink = Color(0xFFE26CA5);
  static const purple = Color(0xFF564CA3);
  static const yellow = Color(0xFFCD9D0F);

  static const Color darkPrimary = Color(0xFF0037AF);
  static const Color secondary = Color(0xFF90a5dd);
  static const Color grandientBlue = Color(0xFF00AEED);
  static const Color borderBlue = Color(0xFFB2DDFF);
  static const Color bgInput = Color(0xff000a3f4d);

  static const Color neutral3 = Color(0xFFA4A4AA);
  static const Color neutral5 = Color(0xFF111112);
  static const Color neutral50 = Color(0xFFF9FAFB);

  static const Color red500 = Color(0xFFF54B60);
  static const Color red300 = Color(0xFFCBC8F6);
  static const Color red200 = Color(0xFFEEECFC);
  static const Color red100 = Color(0xFFF6F6FE);
  static const Color red600 = Color(0xFFDE350C);

  static const Color ink400 = Color(0xFF536087);
  static const Color ink500 = Color(0xFF0E1C45);
  static const Color blue200 = Color(0xFFEDF4FD);
  static const Color ink300 = Color(0xFF9FA4B5);
  static const Color ink200 = Color(0xFFB7BBC7);
  static const Color ink100 = Color(0xFFF6F6FE);
  static const Color ink50 = Color(0xFFF6F6FE);
  static const Color text = Color(0xFF1D1C31);
  static const Color gray_1 = Color(0xFF3A3A3A);
  static const Color gray_2 = Color(0xFFD1D1D1);
  static const Color neutral700 = Color(0xFF344054);
  static const Color neutral400 = Color(0xFF98A2B3);
  static const Color neutral500 = Color(0xFF667085);
  static const Color neutral600 = Color(0xFF475467);
  static const Color neutral800 = Color(0xFF1D2939);
  static const Color neutral900 = Color(0xFF101828);
  static const Color neutral100 = Color(0xFFF2F4F7);
  static const Color neutral200 = Color(0xFFEAECF0);
  static const Color neutral300 = Color(0xFFD0D5DD);

  //Alert

  static const Color green = Color(0xFF059669);

  static const Color orange500 = Color(0xFF5346E0);
  static const Color orange400 = Color(0xFF756BE6);
  static const Color orange300 = Color(0xFFCBC8F6);
  static const Color orange200 = Color(0xFFEEECFC);
  static const Color orange100 = Color(0xFFF6F6FE);

  static const Color blue500 = Color(0xFF5346E0);
  static const Color blue400 = Color(0xFF756bE6);
  static const Color blue300 = Color(0xFFCbC8F6);

  static const Color blue100 = Color(0xFFF6F6FE);
  //gray
  static const Color gray300 = Color(0xFFD0D5DD);
  static const Color gray400 = Color(0xFF98A2B3);
  static const Color gray500 = Color(0xFF667085);
  static const Color gray700 = Color(0xFF344054);
  static const Color gray900 = Color(0xFF101828);

  // Yellow
  static const Color yellow100 = Color(0xFFFDF8ED);
  static const Color yellow600 = Color(0xFFFFAB00);

  //Green
  static const Color green500 = Color(0xFF059666);

  //Black and White
  static const Color descriptionText = Color(0xFF7A869A);
  static const Color discountText = Color(0xFFE5ECFF);
  static const Color discountBackgroundTextGreen = Color(0xFFBAF7C9);
  static const Color discountBackgroundText2 = Color(0xFFBAF7C9);
  static const Color discountBackgroundText = Color(0xFF0045dC);
  static const Color discountText2 = Color(0xFF005114);

  static const Color White300 = Color(0xFFCBC8F6);
  static const Color White200 = Color(0xFFEEECFC);
  static const Color White100 = Color(0xFFF6F6FE);
  static const Color White000 = Color(0xFFFFFFFF);

  static const Color Gray100 = Color(0xFFF2F4F7);
  //Suport Colors
  static const Color red = Color(0xFFE5BAB1);
  static const Color Yellow = Color(0xFFE8E6A6);
  static const Color GreenSP = Color(0xFFBAF7C9);
  static const Color Green2 = Color(0xFF059669);
  static const Color Pink = Color(0xFFF4BEF0);
  static const Color DarkBlue = Color(0xFF000A3F);
  static const Color SuperLightBlue = Color(0xFFEAF3FF);
  static const Color Gray200 = Color(0xFFEAECF0);
  static const Color Gray300 = Color(0xFFD0D5DD);
  static const Color Gray400 = Color(0xFF98A2B3);
  static const Color Gray500 = Color(0xFF667085);
  static const Color Gray700 = Color(0xFF344054);
  static const Color Gray800 = Color(0xFF1D2939);
  static const Color Gray900 = Color(0xFF101828);

  //Primary
  static const Color PrimaryA500 = Color(0xFF0E1C45);
  static const Color PrimaryA400 = Color(0xFF536087);
  static const Color PrimaryA300 = Color(0xFF9FA4B5);
  static const Color PrimaryA200 = Color(0xFFB7BBC7);
  static const Color PrimaryA100 = Color(0xFFE7E8EC);
  static const Color PrimaryA50 = Color(0xFFF3F4F6);
  static const Color Primary = Color(0xFF225478);

  // Semantic
  static const Color Semantic_Blue100 = Color(0xFFF0F4FF);
  static const Color Semantic_Green100 = Color(0xFFF4FCF9);
  static const Color Semantic_Red100 = Color(0xFFFEF6F7);
  static const Color Semantic_Yellow100 = Color(0xFFFFF7E5);
  static const Color Semantic_Green200 = Color(0xFFE8F9F3);
  static const Color Semantic_Green500 = Color(0xFF059666);

  //Other
  static const Color InputBorder = Color(0xFFDBE0E6);
  static const Color TabLine = Color(0xFFE5E5E5);
  static const Color BgIcon = Color(0xFFF9F9F9);
  static const Color BgAppIcon = Color(0xFFEDF3FF);
  static const Color Text = Color(0xFF101828);
  static const Color TextSubtle = Color(0xFF626F86);

  static const Color InputFocus = Color(0xFF2B37A9);

  static const Color Green3 = Color(0xFF059666);
  static const Color Cl_0045DC = Color(0xFF0045DC);
  static const Color Cl_447FFF = Color(0xFF447FFF);
  static const Color Cl_7FA6F9 = Color(0xFF7FA6F9);
  static const Color Cl_CCDDFF = Color(0xFFCCDDFF);
  static const Color SurfaceNeutral = Color(0xff091e420f);
  static const Color Border = Color(0xff091e420f);
  static const Color SurfaceSubtlest = Color(0xffff1f2f4);

  //////
  static const Color lightBlueGreye = Color(0xffF1F6FB);
  static const Color darkBlueGrey= Color(0xff37474F);
  static const Color charcoal= Color(0xff263238);
  static const Color indigo= Color.fromARGB(255, 108, 123, 207);
  static const Color primaryBlue = Color.fromARGB(255, 27, 59, 85);
  static const Color lightGreys = Color(0xffE0E0E0);
  static const Color lightBlueGrey = Color(0xffF5F9FF);
  static const Color indigoAccent = Color(0xffC5CAE9);
  static const Color blueGrey = Color(0xff455A64);

}
