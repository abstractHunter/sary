import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sary/models/anniversary.dart';
import 'package:sary/view_models/main_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AnniversaryCard extends StatelessWidget {
  const AnniversaryCard({super.key, required this.anniversary});

  final Anniversary anniversary;

  String nextAnniversary(AppLocalizations lang) {
    if (anniversary.remaining == 0) {
      return lang.anniversary_of_sarah;
    } else if (anniversary.remaining == 1) {
      return lang.prepare_yourself;
    } else {
      return '${lang.next_anniversary} ${anniversary.remaining} ${lang.days}';
    }
  }

  @override
  Widget build(BuildContext context) {
    MainViewModel mainViewModel = context.watch<MainViewModel>();
    final lang = AppLocalizations.of(context)!;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                anniversary.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${lang.date} : ${anniversary.date.day}/${anniversary.date.month}/${anniversary.date.year}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    anniversary.age.years.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(" ${lang.years}, ", style: const TextStyle(fontSize: 16)),
                  Text(
                    anniversary.age.months.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(" ${lang.months}, ", style: const TextStyle(fontSize: 16)),
                  Text(
                    anniversary.age.days.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(" ${lang.days}", style: const TextStyle(fontSize: 16)),
                ],
              ),
              Text(
                nextAnniversary(lang),
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 0,
          child: PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        TextEditingController nameController = TextEditingController(text: anniversary.name);
                        TextEditingController dayController =
                            TextEditingController(text: anniversary.date.day.toString());
                        TextEditingController monthController =
                            TextEditingController(text: anniversary.date.month.toString());
                        TextEditingController yearController =
                            TextEditingController(text: anniversary.date.year.toString());

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

                                      mainViewModel.updateAnniversary(
                                        Anniversary(
                                          id: anniversary.id,
                                          name: nameController.text,
                                          date: DateTime(
                                            int.parse(yearController.text),
                                            int.parse(monthController.text),
                                            int.parse(dayController.text),
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
                                    child: Text(lang.edit),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Text(lang.edit),
                ),
              ),
              PopupMenuItem(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    mainViewModel.deleteAnniversary(anniversary.id!);
                  },
                  child: Text(lang.delete),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
