/**
 * Created by Trinh Kim Tuan.
 * Date:  5/9/2022
 * Time: 10:09 AM
 */
class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  @override
  String toString() {
    return message;
  }
}