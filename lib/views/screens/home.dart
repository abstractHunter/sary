import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sary/models/anniversary.dart';
import 'package:sary/view_models/main_view_model.dart';
import 'package:sary/views/widgets/aniversary_card.dart';
import 'package:sary/views/widgets/language_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    MainViewModel mainViewModel = context.watch<MainViewModel>();
    final lang = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sary'),
        actions: const <Widget>[
          LanguageWidget(),
          SizedBox(width: 16),
        ],
      ),
      body: mainViewModel.loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  ...mainViewModel.anniversaries
                      .map((anniversary) => AnniversaryCard(
                            anniversary: anniversary,
                          ))
                      .toList(),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // show a form dialog to create a new anniversary
          showDialog(
            context: context,
            builder: (context) {
              TextEditingController nameController = TextEditingController();
              TextEditingController dayController = TextEditingController();
              TextEditingController monthController = TextEditingController();
              TextEditingController yearController = TextEditingController();

              return Dialog(
                insetPadding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  height: 270,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lang.title,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: lang.anniversary_of_sarah,
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lang.day,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 80,
                                child: TextField(
                                  controller: dayController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: '22',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    hintStyle: TextStyle(
                                      color: Colors.grey[500],
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 4,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lang.month,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 80,
                                child: TextField(
                                  controller: monthController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: '04',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    hintStyle: TextStyle(
                                      color: Colors.grey[500],
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 4,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lang.year,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 80,
                                child: TextField(
                                  controller: yearController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: '1996',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    hintStyle: TextStyle(
                                      color: Colors.grey[500],
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 4,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            if (nameController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(lang.enter_name),
                                ),
                              );
                              return;
                            }

                            if (dayController.text.isEmpty ||
                                int.parse(dayController.text) < 1 ||
                                int.parse(dayController.text) > 31) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(lang.enter_valid(lang.day)),
                                ),
                              );
                              return;
                            }

                            if (monthController.text.isEmpty ||
                                int.parse(monthController.text) < 1 ||
                                int.parse(monthController.text) > 12) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(lang.enter_valid(lang.month)),
                                ),
                              );
                              return;
                            }

                            if (yearController.text.isEmpty ||
                                int.parse(yearController.text) < 1 ||
                                int.parse(yearController.text) > DateTime.now().year) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(lang.enter_valid(lang.year)),
                                ),
                              );
                              return;
                            }

                            if (dayController.text.length == 1) {
                              dayController.text = '0${dayController.text}';
                            }

                            if (monthController.text.length == 1) {
                              monthController.text = '0${monthController.text}';
                            }

                            // justify the year to 4 digits
                            while (yearController.text.length < 4) {
                              yearController.text = '0${yearController.text}';
                            }

                            mainViewModel.createAnniversary(
                              Anniversary(
                                name: nameController.text,
                                date: DateTime.parse(
                                  '${yearController.text}-${monthController.text}-${dayController.text}',
                                ),
                              ),
                            );
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(lang.add),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
