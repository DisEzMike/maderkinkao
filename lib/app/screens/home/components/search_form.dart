import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maderkinkao/app/utils/constants.dart';
import '../../../utils/responsive.dart';
class SearchForm extends StatefulWidget {
  const SearchForm({super.key});

  @override
  State<SearchForm> createState() => _SearchFormState();
}

List<String> list = <String>['โรงอาหาร C', 'Two', 'Three', 'Four'];

class _SearchFormState extends State<SearchForm> {
  String? dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (!Responsive.isMobile(context)) const Spacer(),
            Expanded(
              flex: 2,
              child: DecoratedBox(
                decoration: gNavBoxDecoration,
                child: DropdownButtonFormField<String>(
                    value: dropdownValue,
                    borderRadius: BorderRadius.circular(kDefaultPadding),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: kDefaultPadding / 3,
                            horizontal: kDefaultPadding / 2),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(kDefaultPadding)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(kDefaultPadding),
                            borderSide: const BorderSide(
                              color: Colors.black26,
                              width: 1,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(kDefaultPadding),
                            borderSide: const BorderSide(
                                color: Colors.black26, width: 1)),
                        filled: true,
                        fillColor: Colors.white),
                    style: GoogleFonts.kanit(
                        textStyle: const TextStyle(
                      color: Colors.black,
                      letterSpacing: 1.2,
                    )),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value;
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()),
              ),
            ),
            // if (!Responsive.isMobile(context)) const Spacer(),
            // if (!Responsive.isMobile(context)) const Spacer(),
            if (!Responsive.isMobile(context)) const Spacer(),
          ],
        ),
        Row(
          children: [
            if (!Responsive.isMobile(context)) const Spacer(),
            Expanded(
              flex: 5,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: kDefaultPadding * 1.5),
                child: DecoratedBox(
                  decoration: gNavBoxDecoration,
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'ค้นหาร้านอาหารที่ใช่',
                        labelStyle: const TextStyle(
                            color: Colors.black, letterSpacing: 1.2),
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(kDefaultPadding),
                            borderSide: const BorderSide(
                              color: Colors.black26,
                              width: 1,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(kDefaultPadding),
                            borderSide: const BorderSide(
                              color: Colors.black26,
                              width: 1,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(kDefaultPadding),
                            borderSide: const BorderSide(
                                color: Colors.black26, width: 1)),
                        filled: true,
                        fillColor: Colors.white),
                    style: const TextStyle(
                      color: Colors.black,
                      letterSpacing: 1.1,
                      fontSize: kDefaultFontSize * 1.1,
                    ),
                  ),
                ),
              ),
            ),
            if (!Responsive.isMobile(context)) const Spacer(),
          ],
        ),
      ],
    );
  }
}
