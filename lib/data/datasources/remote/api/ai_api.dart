import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fpdart/fpdart.dart';
import 'package:intl/intl.dart';
import 'package:time_management_ai/constants/key_ai.dart';
import 'package:time_management_ai/data/datasources/remote/constants/endpoints.dart';
import 'package:time_management_ai/utils/failure.dart';
import 'package:time_management_ai/domain/entities/schedule_entity.dart';
import 'package:time_management_ai/domain/entities/task_input_entity.dart';

class AiApi {
  var client = http.Client();

  Future<Either<Failure, List<ScheduleEntity>>> processAiInputApi(
      TaskInputEntity params) async {
    final nowUtc = DateTime.now();
    final formattedDate = DateFormat('dd/MM/yyyy').format(nowUtc);
    final response = await client.post(
      Uri.parse(Endpoints.chatResponses),
      headers: {
        'Authorization': 'Bearer $OPENAI_API_KEY',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": "gpt-4.1",
        "input": [
          {
            "role": "system",
            "content":
                "Tôi sẽ cung cấp một danh sách các công việc cần làm trong ngày. Hãy phân tích và chia nhỏ chúng thành các nhiệm vụ cụ thể theo cấu trúc JSON. Yêu cầu đầu ra: Trả về duy nhất một mảng JSON, trong đó mỗi phần tử bao gồm: - \"title\": một tiêu đề tổng quát mô tả chủ đề của các công việc trong ngày (ví dụ: \"Du lịch\", \"Công việc\", \"Học tập\"). - \"date\" là ngày đúng bằng $formattedDate, định dạng \"dd/MM/yyyy\". - \"tasks\": là một mảng các nhiệm vụ nhỏ trong ngày hôm đó. Mỗi task có dạng một object gồm: - \"id\": một mã định danh duy nhất cho cả nhóm công việc trong ngày (random, kiểu chuỗi hoặc số) , kiểu chuỗi hoặc số. - \"time\": khoảng thời gian thực hiện, định dạng \"HH:mm - HH:mm\" và không được trùng lặp giữa các nhiệm vụ. - \"description\": mô tả ngắn gọn (1–5 từ) cho nhiệm vụ, thể hiện nội dung chính. Lưu ý quan trọng: - Thời gian các nhiệm vụ phải logic, liền mạch và không trùng lặp. - Không được trả về bất kỳ nội dung nào khác ngoài mảng JSON kết quả. Dưới đây là danh sách công việc đầu vào: \"${params.inputText}\" Ví dụ đầu ra: [{\"id\": \"01\",\"title\": \"Công việc\",\"date\": \"29/07/2025\", \"tasks\": [{\"id\": \"1\",\"time\": \"08:00 - 09:00\",\"description\": \"Họp nhóm phát triển\"},{\"id\": \"2\",\"time\": \"09:00 - 10:30\",\"description\": \"Viết báo cáo tuần\"}]},{\"id\": \"02\",\"title\": \"Học tập\",\"date\": \"29/07/2025\",\"tasks\": [{\"id\": \"3\",\"time\": \"14:00 - 15:00\",\"description\": \"Đi bơi\"},{\"id\": \"4\",\"time\": \"15:15 - 16:00\",\"description\": \"Đọc sách\"}]}]"
          },
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final content = data['output'][0]['content'][0]['text'];
      final List<dynamic> listData = jsonDecode(content);
      final taskList = listData
          .map<ScheduleEntity>((item) => ScheduleEntity.fromJson(item))
          .toList();
      return Right(taskList);
    } else {
      throw Exception('Failed to extract tasks');
    }
  }
}
