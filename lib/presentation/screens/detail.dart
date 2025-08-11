import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:time_management_ai/constants/app_colors.dart';
import 'package:time_management_ai/constants/texts.dart';
import 'package:time_management_ai/di/injector.dart';
import 'package:time_management_ai/domain/entities/schedule_entity.dart';
import 'package:time_management_ai/domain/entities/task_entity.dart';
import 'package:time_management_ai/presentation/stores/add_schedule_store.dart';
import 'package:time_management_ai/utils/context_extension.dart';

class DetailScreen extends StatefulWidget {
  final ScheduleEntity? data;

  const DetailScreen({
    super.key,
    this.data,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final AddScheduleStore store = getIt<AddScheduleStore>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    store.loadTasksFromPrefs();
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlueGreye,
      appBar: _buildAppBar(context),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          await store.loadTasksFromPrefs();
        },
        child: _buildBody(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.indigo,
      centerTitle: true,
      title: Text(
        'Chi tiết công việc',
        style: CustomTextStyle.textLarge(context).copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.White000,
        ),
      ),
      leading: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/').then((_) async {
            await store.loadTasksFromPrefs();
          });
        },
        child:
            const Icon(Icons.chevron_left, size: 30, color: AppColors.White000),
      ),
      actions: [
        Observer(
          builder: (_) {
            return IconButton(
              icon: const Icon(Icons.delete_outline, color: AppColors.White000),
              onPressed: () async {
                await store.deleteTask(widget.data!.title);
                Navigator.pushNamed(context, '/').then((_) async {
                  await store.loadTasksFromPrefs();
                }); // Xoá cả schedule thì quay về màn trước
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Observer(builder: (context) {
      final totalCompleted =
          widget.data!.tasks.where((t) => t.isCompleted).length;
      final totalPending = widget.data!.tasks.length - totalCompleted;
      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCounterBox(
                    "Đang thực hiện", totalPending, AppColors.red500),
                _buildCounterBox("Hoàn thành", totalCompleted, AppColors.green),
              ],
            ),
            16.height,
            _buildTaskDetailList(context),
          ],
        ),
      );
    });
  }

  Widget _buildCounterBox(String title, int count, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.White000,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              "$count",
              style: CustomTextStyle.textLarge(context).copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: CustomTextStyle.customTextStyle().copyWith(
                color: AppColors.neutral500,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskDetailList(BuildContext context) {
    if (widget.data == null || widget.data!.tasks.isEmpty) {
      return Column(
        children: [
          350.height,
          Center(
            child: Text(
              'Không có lịch trình nào trong ngày này.',
              style: CustomTextStyle.textNormal(context).copyWith(
                color: AppColors.gray500,
              ),
            ),
          ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Ngày ${_formatDate(widget.data!.date)}",
            style: CustomTextStyle.textNormal(context).copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.darkBlueGrey,
            ),
          ),
        ),
        Column(
          children: widget.data!.tasks
              .map((item) => _buildTaskItem(context, item))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildTaskItem(BuildContext context, TaskEntity item) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.White000,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 10, right: 5),
        leading: item.isCompleted
            ? const Icon(Icons.check_circle, color: AppColors.green)
            : const SizedBox(),
        title: Text(
          "${item.time} ${item.description}",
          style: CustomTextStyle.textNormal(context).copyWith(
            fontWeight: FontWeight.w400,
            color: AppColors.charcoal,
          ),
        ),
        trailing: IconButton(
          icon:
              const Icon(Icons.more_horiz, size: 24, color: AppColors.gray500),
          onPressed: () => _showTaskActionDialog(context, item),
        ),
      ),
    );
  }

  void _showTaskActionDialog(BuildContext context, TaskEntity item) {
    showDialog<void>(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: AppColors.White000,
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Text(
                  'Bạn muốn hoàn thành công việc này?',
                  style: CustomTextStyle.customTextStyle().copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.indigo,
                  ),
                ),
              ),
              const Divider(height: 0, color: AppColors.neutral200),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        await store.deleteTaskById(item.id);
                        setState(() {
                          widget.data!.tasks
                              .removeWhere((task) => task.id == item.id);
                        });

                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Text(
                          'Xoá',
                          style: CustomTextStyle.customTextStyle().copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.red500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 0.6, color: AppColors.neutral200),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          item.isCompleted = true;
                        });
                        await store.updateTaskCompletion(item.id, true);
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Text(
                          'Hoàn thành',
                          style: CustomTextStyle.customTextStyle().copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.neutral500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
