import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mithub_app/design/colors.dart';
import 'package:mithub_app/design/theme_extension.dart';
import 'package:mithub_app/design/widget/app_bar.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({super.key});

  @override
  State<MarketplacePage> createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  final List<String> _options = ['All', 'My Product'];
  String _selectedOptions = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: textAppBar('MarketPlace'),
      floatingActionButton: _selectedOptions != 'All'
          ? FloatingActionButton(
              backgroundColor: FunDsColors.primaryBase,
              tooltip: 'Increment',
              onPressed: () {},
              child: const Icon(Icons.add, color: Colors.white, size: 28),
            )
          : null,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: Row(
              children: _options.map((option) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ChoiceChip(
                    selectedColor: _selectedOptions == option
                        ? FunDsColors.primaryBase
                        : FunDsColors.neutralSix,
                    label: Text(
                      option,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: _selectedOptions == option
                            ? FunDsColors.white
                            : FunDsColors.neutralTwo,
                      ),
                    ),
                    selected: _selectedOptions.contains(option),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedOptions = option;
                        }
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SizedBox(
              height: 40,
              width: 380,
              child: Center(
                child: TextField(
                  style: context.textTheme.titleMedium,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        width: 1,
                        color: FunDsColors.primaryBase,
                      ),
                    ),
                    hintText: "Search by Name",
                    hintStyle: GoogleFonts.lato(
                      color: const Color(0xffb2b2b2),
                      fontSize: 16,
                    ),
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4.h,
                  crossAxisSpacing: 4.w,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Container(
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                  image: NetworkImage(
                                    'https://pbs.twimg.com/media/BEctmM8CMAACKlo.jpg',
                                  ),
                                  fit: BoxFit.fitWidth,
                                )),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Kambing Gunung",
                                      style: context.textTheme.bodyLarge,
                                    ),
                                    Text(
                                      'Rp5.000 ',
                                      style: context.textTheme.titleSmall
                                          ?.copyWith(
                                        color: FunDsColors.primaryBase,
                                      ),
                                    ),
                                    Text(
                                      textAlign: TextAlign.start,
                                      'Surabaya, 16Km',
                                      style: context.textTheme.bodySmall
                                          ?.copyWith(
                                        color: FunDsColors.neutralTwo,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
