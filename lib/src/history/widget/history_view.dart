import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ocr_visitor/env/extension/on_context.dart';
import 'package:ocr_visitor/src/form_visitor/state/form_cubit.dart';
import 'package:ocr_visitor/src/history/state/history_cubit.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController startDateController = TextEditingController();
    TextEditingController endDateController = TextEditingController();
    int index = 0;

    return Scaffold(
      body: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoaded) {
            return Stack(
              children: [
                Container(
                  height: 50,
                  width: double.infinity,
                  color: Colors.lightBlue,
                ),
                SafeArea(
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(24),
                            bottomLeft: Radius.circular(24),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Riwayat Pengunjung",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: DefaultTabController(
                          length: 2,
                          initialIndex: index,
                          child: Column(
                            children: [
                              const TabBar(
                                indicatorColor: Colors.blue,
                                labelColor: Colors.blue,
                                tabs: [
                                  Tab(
                                    text: "Pengunjung Aktif",
                                  ),
                                  Tab(
                                    text: "Riwayat Pengujung",
                                  )
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    RefreshIndicator(
                                        onRefresh: () {
                                          context
                                              .read<HistoryCubit>()
                                              .getVisitorActive();
                                          return context
                                              .read<FormCubit>()
                                              .getResidentData();
                                        },
                                        child: SingleChildScrollView(
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          child: Column(
                                            children: state.histories.isNotEmpty
                                                ? state.histories.map(
                                                    (e) {
                                                      Duration time =
                                                          DateTime.parse(
                                                                  e.createdAt!)
                                                              .difference(
                                                        DateTime.now(),
                                                      );
                                                      return InkWell(
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (_) {
                                                              return AlertDialog(
                                                                title:
                                                                    const Text(
                                                                  "Detail Kunjungan",
                                                                ),
                                                                titleTextStyle:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 24,
                                                                ),
                                                                shape:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    8,
                                                                  ),
                                                                ),
                                                                content:
                                                                    SizedBox(
                                                                  height: 160,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                          "Nama : ${e.name}"),
                                                                      Text(
                                                                          "Pemilik Rumah : ${e.resident!.name}"),
                                                                      Text(
                                                                          "Dari Tanggal : ${DateFormat('EEEE, dd-MM-yyyy', 'id_ID').format(
                                                                        DateTime.parse(
                                                                            e.createdAt!),
                                                                      )}"),
                                                                      Text(
                                                                          "Lama Kunjungan : ${time.inDays == 0 ? '' : time.inDays.toString().replaceAll('-', '')}${time.inDays != 0 ? ' hari ' : ''}${time.inHours == 0 || time.inHours <= -24 ? '' : time.inHours.toString().replaceAll('-', '')}${time.inHours <= -24 ? '' : ' jam'} ${time.inMinutes <= -60 ? '' : time.inMinutes.toString().replaceAll('-', '')} ${time.inMinutes <= -60 ? '' : 'menit'}"),
                                                                      const SizedBox(
                                                                        height:
                                                                            8,
                                                                      ),
                                                                      Center(
                                                                        child:
                                                                            ElevatedButton(
                                                                          onPressed:
                                                                              () {
                                                                            showDialog(
                                                                              context: context,
                                                                              builder: (_) {
                                                                                return AlertDialog(
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(
                                                                                      8,
                                                                                    ),
                                                                                  ),
                                                                                  title: Center(
                                                                                    child: Text(
                                                                                      "Apakah pengunjung ${e.name} ingin keluar?",
                                                                                      textAlign: TextAlign.center,
                                                                                    ),
                                                                                  ),
                                                                                  titleTextStyle: const TextStyle(
                                                                                    color: Colors.black,
                                                                                    fontSize: 14,
                                                                                  ),
                                                                                  actions: [
                                                                                    ElevatedButton(
                                                                                      onPressed: () {
                                                                                        context.close();
                                                                                        context.close();
                                                                                      },
                                                                                      style: ElevatedButton.styleFrom(
                                                                                        shape: RoundedRectangleBorder(
                                                                                          borderRadius: BorderRadius.circular(8),
                                                                                        ),
                                                                                      ),
                                                                                      child: const Text(
                                                                                        "Tidak",
                                                                                        style: TextStyle(
                                                                                          color: Colors.black,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    ElevatedButton(
                                                                                      onPressed: () {
                                                                                        context.read<HistoryCubit>().checkout(
                                                                                              e.id!,
                                                                                            );
                                                                                        context.close();
                                                                                        context.close();
                                                                                      },
                                                                                      style: ElevatedButton.styleFrom(
                                                                                        backgroundColor: Colors.lightGreenAccent.shade700,
                                                                                        shape: RoundedRectangleBorder(
                                                                                          borderRadius: BorderRadius.circular(8),
                                                                                        ),
                                                                                      ),
                                                                                      child: const Text(
                                                                                        "Ya",
                                                                                        style: TextStyle(
                                                                                          color: Colors.white,
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                  actionsAlignment: MainAxisAlignment.center,
                                                                                );
                                                                              },
                                                                            );
                                                                          },
                                                                          style:
                                                                              ElevatedButton.styleFrom(
                                                                            backgroundColor:
                                                                                Colors.lightGreenAccent.shade700,
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              const Text(
                                                                            "Checkout",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(
                                                            16,
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 8,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: Colors
                                                                  .grey[300]!,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              8,
                                                            ),
                                                          ),
                                                          height: 100,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                    130,
                                                                child: Text(
                                                                  "Nama : ${e.name}\nPemilik Rumah: ${e.resident!.name}\nDari Tanggal : ${DateFormat('EEEE, dd-MM-yyyy', 'id_ID').format(
                                                                    DateTime.parse(
                                                                        e.createdAt!),
                                                                  )}\nLama Kunjungan : ${time.inDays == 0 ? '' : time.inDays.toString().replaceAll('-', '')}${time.inDays != 0 ? ' hari ' : ''}${time.inHours == 0 || time.inHours <= -24 ? '' : time.inHours.toString().replaceAll('-', '')}${time.inHours <= -24 ? '' : ' jam'} ${time.inMinutes <= -60 ? '' : time.inMinutes.toString().replaceAll('-', '')} ${time.inMinutes <= -60 ? '' : 'menit'}",
                                                                  maxLines: 5,
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (_) {
                                                                      return AlertDialog(
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                            8,
                                                                          ),
                                                                        ),
                                                                        title:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "Apakah pengunjung ${e.name} ingin keluar?",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          ),
                                                                        ),
                                                                        titleTextStyle:
                                                                            const TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                        actions: [
                                                                          ElevatedButton(
                                                                            onPressed:
                                                                                () {
                                                                              context.close();
                                                                            },
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                const Text(
                                                                              "Tidak",
                                                                              style: TextStyle(
                                                                                color: Colors.black,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          ElevatedButton(
                                                                            onPressed:
                                                                                () {
                                                                              context.read<HistoryCubit>().checkout(
                                                                                    e.id!,
                                                                                  );
                                                                              context.close();
                                                                            },
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              backgroundColor: Colors.lightBlue,
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                const Text(
                                                                              "Ya",
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                        actionsAlignment:
                                                                            MainAxisAlignment.center,
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 80,
                                                                  height: double
                                                                      .infinity,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .lightGreenAccent
                                                                        .shade700,
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .only(
                                                                      topRight:
                                                                          Radius.circular(
                                                                              8),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              8),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      const Center(
                                                                    child: Text(
                                                                      "Checkout",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ).toList()
                                                : [
                                                    const SizedBox(
                                                      height: 100,
                                                    ),
                                                    const Center(
                                                      child: Text(
                                                          "Tidak Ada Data Pengunjung"),
                                                    ),
                                                  ],
                                          ),
                                        )),
                                    RefreshIndicator(
                                      onRefresh: () {
                                        context
                                            .read<HistoryCubit>()
                                            .getVisitorActive();
                                        return context
                                            .read<FormCubit>()
                                            .getResidentData();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: SingleChildScrollView(
                                                physics:
                                                    const AlwaysScrollableScrollPhysics(),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "Cari Riwayat Pengunjung",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  2 -
                                                              16,
                                                          child: TextFormField(
                                                            readOnly: true,
                                                            controller:
                                                                startDateController,
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                vertical: 0,
                                                                horizontal: 10,
                                                              ),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              hintText:
                                                                  'Dari Tanggal',
                                                              suffixIcon:
                                                                  const Icon(Icons
                                                                      .calendar_month_outlined),
                                                            ),
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return 'Tanggal dimulai tidak boleh kosong';
                                                              }
                                                              return null;
                                                            },
                                                            onTap: () async {
                                                              startDateController
                                                                      .text =
                                                                  await (selectDate(
                                                                      context));
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  2 -
                                                              16,
                                                          child: TextFormField(
                                                            readOnly: true,
                                                            controller:
                                                                endDateController,
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                vertical: 0,
                                                                horizontal: 10,
                                                              ),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              hintText:
                                                                  'Hingga Tanggal',
                                                              suffixIcon:
                                                                  const Icon(Icons
                                                                      .calendar_month_outlined),
                                                            ),
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return 'Tanggal dimulai tidak boleh kosong';
                                                              }
                                                              return null;
                                                            },
                                                            onTap: () async {
                                                              endDateController
                                                                      .text =
                                                                  await (selectDate(
                                                                      context));
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        if (startDateController
                                                                .text
                                                                .isNotEmpty &&
                                                            endDateController
                                                                .text
                                                                .isNotEmpty) {
                                                          context
                                                              .read<
                                                                  HistoryCubit>()
                                                              .getVisitorHistory(
                                                                  startDateController
                                                                      .text,
                                                                  endDateController
                                                                      .text);
                                                          index = 1;
                                                        } else {
                                                          context.alert(
                                                            label:
                                                                "Tanggal tidak boleh kosong",
                                                            color: Colors.red,
                                                          );
                                                        }
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.lightBlue,
                                                        minimumSize: const Size(
                                                          double.infinity,
                                                          45,
                                                        ),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ),
                                                      child: const Text(
                                                        "Cari Data Riwayat Pengunjung",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    const Divider(),
                                                    Column(
                                                      children: state
                                                              .historiesByDate!
                                                              .isNotEmpty
                                                          ? state
                                                              .historiesByDate!
                                                              .map(
                                                              (e) {
                                                                return InkWell(
                                                                  onTap: () {
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (_) {
                                                                        Duration
                                                                            time =
                                                                            DateTime.parse(e.createdAt!).difference(
                                                                          DateTime.parse(
                                                                              e.updatedAt!),
                                                                        );
                                                                        return AlertDialog(
                                                                          title:
                                                                              const Text(
                                                                            "Detail Kunjungan",
                                                                          ),
                                                                          titleTextStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                24,
                                                                          ),
                                                                          shape:
                                                                              OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide.none,
                                                                            borderRadius:
                                                                                BorderRadius.circular(
                                                                              8,
                                                                            ),
                                                                          ),
                                                                          content:
                                                                              SizedBox(
                                                                            height:
                                                                                160,
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text("Nama : ${e.name}"),
                                                                                Text("Pemilik Rumah : ${e.resident!.name}"),
                                                                                Text("Dari Tanggal : ${DateFormat('EEEE, dd-MM-yyyy', 'id_ID').format(
                                                                                  DateTime.parse(e.createdAt!),
                                                                                )}"),
                                                                                Text("Lama Kunjungan : ${time.inDays == 0 ? '' : time.inDays.toString().replaceAll('-', '')}${time.inDays != 0 ? ' hari ' : ''}${time.inHours == 0 || time.inHours <= -24 ? '' : time.inHours.toString().replaceAll('-', '')}${time.inHours <= -24 ? '' : ' jam'} ${time.inMinutes <= -60 ? '' : time.inMinutes.toString().replaceAll('-', '')} ${time.inMinutes <= -60 ? '' : 'menit'}"),
                                                                                const SizedBox(
                                                                                  height: 8,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                      5,
                                                                    ),
                                                                    margin: const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            8),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .grey[400]!,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        8,
                                                                      ),
                                                                    ),
                                                                    height: 80,
                                                                    child: Text(
                                                                      "${e.name} Berkunjung ke rumah ${e.resident!.name} pada ${DateFormat('EEEE, dd-MM-yyyy', 'id_ID').format(
                                                                        DateTime.parse(
                                                                            e.createdAt!),
                                                                      )}",
                                                                      maxLines:
                                                                          4,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ).toList()
                                                          : [
                                                              const Center(
                                                                child: Text(
                                                                    "Tidak ada data riwayat pengunjung pada tanggal tersebut"),
                                                              ),
                                                            ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          if (state is HistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return const SizedBox();
        },
      ),
    );
  }
}

Future<String> selectDate(BuildContext context) async {
  MaterialLocalizations.of(context);
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(DateTime.now().year - 1),
    lastDate: DateTime.now(),
    selectableDayPredicate: (day) {
      if (day.isAfter(DateTime.now())) {
        return false;
      }
      return true;
    },
  );
  if (picked != null) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
    return formattedDate;
  } else {
    return '';
  }
}
