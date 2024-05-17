import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mithub_app/core/debouncer.dart';
import 'package:mithub_app/design/colors.dart';
import 'package:mithub_app/design/theme_extension.dart';
import 'package:mithub_app/design/widget/app_bar.dart';
import 'package:mithub_app/feature/marketplace/marketplace_viewmodel.dart';
import 'package:mithub_app/utils/result.dart';
import 'package:provider/provider.dart';

class MarketplacePage extends StatelessWidget {
  const MarketplacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MarketplaceViewModel>(
      create: (context) => MarketplaceViewModel()..onViewLoaded(),
      child: const MarketplaceView(),
    );
  }
}

class MarketplaceView extends StatefulWidget {
  const MarketplaceView({super.key});

  @override
  State<MarketplaceView> createState() => _MarketplaceViewState();
}

class _MarketplaceViewState extends State<MarketplaceView> {
  final List<String> _options = ['All', 'My Product'];
  String _selectedOptions = 'All';
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<MarketplaceViewModel>();
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
                  controller: controller,
                  style: context.textTheme.bodyLarge,
                  onChanged: (value) {
                    Debouncer(milliseconds: 800).run(() {
                      vm.fetchData(keyword:controller.text.toString());
                    });
                  },
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
                itemCount: vm.listData.result.dataOrNull?.length,
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
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: NetworkImage(
                                      'http://20.20.24.134:3000' +
                                          (vm.listData.result.dataOrNull?[index].file?.path.toString() ?? '')),
                                  fit: BoxFit.fitWidth,
                                )),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      vm.listData.result.dataOrNull?[index].name ??
                                          '',
                                      style: context.textTheme.bodyLarge,
                                    ),
                                    Text(
                                      vm.listData.result.dataOrNull?[index].price
                                          .toString() ??
                                          '',
                                      style: context.textTheme.titleSmall
                                          ?.copyWith(
                                        color: FunDsColors.primaryBase,
                                      ),
                                    ),
                                    Text(
                                      textAlign: TextAlign.start,
                                      'Surabaya, 16Km',
                                      style:
                                          context.textTheme.bodySmall?.copyWith(
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
