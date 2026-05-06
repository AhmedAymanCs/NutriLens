import 'package:dio/dio.dart';
import 'package:nutrilens/features/add_meal/data/models/user_model.dart';
// هنا الداتا سورس عاوزها تبقا هي الاستراكشر ال انا ماشي عليها بس اما كل حاجه وكل اتشك يتعمل في الريبو والكيوبيت 
// الداتا سورس كله هيتشال وبعدين هستخدم الحاجات ال محمد عاملها في الفاير استور واعمل الشغل كله في الريبو
abstract class AddMealRemoteDataSource {
  Future<void> addMeal(MealModel meal);
  Future<List<MealModel>> getMeals(); 
  Future<List<MealModel>> searchMeals(String query);
}
// هنا هشيل ال ديو اصلا لاننا هنستخدم ملف جيسون جاهز 
class AddMealRemoteDataSourceImpl implements AddMealRemoteDataSource {
  final Dio dio;
  AddMealRemoteDataSourceImpl({required this.dio});

  final String _baseUrl = "https://your-api.com/api";
// هجيب من الفاير استور  مفيش ريسبونس 
  @override
  Future<List<MealModel>> getMeals() async {
    try {
      final response = await dio.get("$_baseUrl/meals");
      return (response.data as List)
          .map((json) => MealModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception("فشل جلب البيانات من السيرفر");
    }
  }

  @override
  Future<List<MealModel>> searchMeals(String query) async {
    try {
      final response = await dio.get(
        "$_baseUrl/search",
        queryParameters: {'q': query},
      );
      return (response.data as List)
          .map((json) => MealModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception("فشل عملية البحث");
    }
  }

  @override
  Future<void> addMeal(MealModel meal) async {
    try {
      await dio.post("$_baseUrl/meals", data: meal.toJson());
    } catch (e) {
      throw Exception("فشل إضافة الوجبة");
    }
  }
}