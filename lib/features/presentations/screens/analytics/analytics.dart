import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:turnstileadmin_v2/common/TAppBar.dart';
import 'package:turnstileadmin_v2/utils/constants/sizes.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/Thelper_functions.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? TColors.textBlack : TColors.textWhite,
      appBar: TAppBar(
        title: 'Analytics',
        leadingIcon: Iconsax.notification, onLeadingIconPressed: () {  },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 120,
                  width: 160,
                  decoration: BoxDecoration(
                    color: TColors.inputBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "12 Sites",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: TColors.textBlack),
                        ),
                        Text(
                          "is being processed",
                          style:
                              TextStyle(fontSize: 14, color: TColors.textBlack),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  width: 160,
                  decoration: BoxDecoration(
                    color: TColors.inputBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "52 Staff",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: TColors.textBlack),
                        ),
                        Text(
                          "active workers",
                          style:
                              TextStyle(fontSize: 14, color: TColors.textBlack),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: TSizes.spaceBtwSection),
            Container(
              height: 400,
              width: 350,
              decoration: BoxDecoration(
                color: TColors.inputBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Monthly project completion",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: TColors.textBlack),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: LineChart(
                        LineChartData(
                          lineBarsData: [
                            LineChartBarData(
                              spots: [
                                FlSpot(0, 0),
                                FlSpot(1, 15),
                                FlSpot(2, 30),
                                FlSpot(3, 45),
                                FlSpot(4, 60),
                                FlSpot(5, 75),
                              ],
                              isCurved: true,
                              colors: [TColors.primaryColorBorder],
                              barWidth: 4,
                              isStrokeCapRound: true,
                              dotData: FlDotData(show: false),
                              belowBarData: BarAreaData(show: false),
                            ),
                          ],
                          titlesData: FlTitlesData(
                            bottomTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 22,
                              getTextStyles: (context, value) => TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              margin: 10,
                              getTitles: (value) {
                                switch (value.toInt()) {
                                  case 0:
                                    return 'Jan';
                                  case 1:
                                    return 'Feb';
                                  case 2:
                                    return 'Mar';
                                  case 3:
                                    return 'Apr';
                                  case 4:
                                    return 'May';
                                  case 5:
                                    return 'Jun';
                                  default:
                                    return '';
                                }
                              },
                            ),
                            leftTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 28,
                              getTextStyles: (context, value) => TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              margin: 12,
                              interval: 15,
                              getTitles: (value) {
                                if (value == 0) {
                                  return '0';
                                } else if (value == 15) {
                                  return '15';
                                } else if (value == 30) {
                                  return '30';
                                } else if (value == 45) {
                                  return '45';
                                } else if (value == 60) {
                                  return '60';
                                } else if (value == 75) {
                                  return '75';
                                }
                                return '';
                              },
                            ),
                          ),
                          gridData: FlGridData(
                            show: false,
                            checkToShowHorizontalLine: (value) =>
                                value % 15 == 0,
                            getDrawingHorizontalLine: (value) => FlLine(
                              color: Colors.grey,
                              strokeWidth: 0.5,
                            ),
                          ),
                          borderData: FlBorderData(
                            show: true,
                            border: Border(
                              bottom: BorderSide(color: Colors.black, width: 1),
                              left: BorderSide(color: Colors.black, width: 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwSection),
            Container(
              width: 350,
              decoration: BoxDecoration(
                color: TColors.inputBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  // Ensure the Column occupies minimum vertical space needed
                  children: [
                    Text(
                      "Monthly project completion",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: TColors.textBlack),
                    ),
                    SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 3,
                          child: AspectRatio(
                            aspectRatio: 1.2,
                            child: PieChart(
                              PieChartData(
                                sections: [
                                  PieChartSectionData(
                                    value: 30,
                                    color: TColors.analyticsColor2,
                                    title: '30%',
                                    radius: 60,
                                    titleStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  PieChartSectionData(
                                    value: 20,
                                    color: TColors.analyticsColor1,
                                    title: '20%',
                                    radius: 60,
                                    titleStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  PieChartSectionData(
                                    value: 50,
                                    color: TColors.primaryColorBorder,
                                    title: '50%',
                                    radius: 60,
                                    titleStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                                sectionsSpace: 0,
                                centerSpaceRadius: 20,
                                centerSpaceColor: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: TColors.analyticsColor2,
                                      )),
                                  SizedBox(width: TSizes.sm),
                                  Text(
                                    '20 inactive',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: TColors.textBlack,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: TColors.primaryColorBorder,
                                      )),
                                  SizedBox(width: TSizes.sm),
                                  Text(
                                    '36 active',
                                    style: TextStyle(
                                        fontSize: 16, color: TColors.textBlack),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: TColors.analyticsColor1,
                                      )),
                                  SizedBox(width: TSizes.sm),
                                  Text(
                                    '16 pending',
                                    style: TextStyle(
                                        fontSize: 16, color: TColors.textBlack),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
