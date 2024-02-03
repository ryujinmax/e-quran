import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_ahlul_quran_app/common/contants.dart';
import 'package:flutter_ahlul_quran_app/cubit/surah/surah_cubit.dart';
import 'package:flutter_ahlul_quran_app/ui/ayat_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TesPage extends StatefulWidget {
  const TesPage({Key? key}) : super(key: key);

  @override
  State<TesPage> createState() => _TesPageState();
}

class _TesPageState extends State<TesPage> {
  get imageSliders => null;

  @override
  void initState() {
    context.read<SurahCubit>().getAllSurah();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 60.0, left: 17.0, right: 17.0, bottom: 15.0),
            child: TextField(
              style: const TextStyle(color: AppColors.primary),
              decoration: InputDecoration(
                hintText: 'Search Surah...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
                prefixIcon: const Icon(Icons.search,
                    color: AppColors.primary, size: 30),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.h),
            padding: const EdgeInsets.only(bottom: 20.0),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
                reverse: false,
              ),
              items: [
                'assets/ip13_pro.jpg',
                'assets/m_pro_16.png',
                'assets/asus_zenbook_f13_ux363e.jpg',
                'assets/ip13_pro.jpg',
              ].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(color: Colors.amber),
                      child: Image(
                        image: AssetImage(i),
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          BlocBuilder<SurahCubit, SurahState>(builder: (context, state) {
            if (state is SurahLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (state is SurahLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final surah = state.listSurah[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AyatPage(surah: surah);
                      }));
                    },
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.primary,
                          child: Text(
                            '${surah.nomor}',
                            style: const TextStyle(color: AppColors.white),
                          ),
                        ),
                        title: Text('${surah.namaLatin}, ${surah.nama}'),
                        subtitle: Text('${surah.arti}, ${surah.jumlahAyat}'),
                      ),
                    ),
                  );
                },
                itemCount: state.listSurah.length,
              );
            }

            if (state is SurahError) {
              return Center(
                child: Text(state.message),
              );
            }

            return const Center(
              child: Text('No Data'),
            );
          }),
        ],
      ),
    );
  }
}
