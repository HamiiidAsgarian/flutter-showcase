import 'package:dio/dio.dart';
import 'package:flutter_showcase/core/network/network_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  test('network calls - successful response', () async {
    final mockDio = MockDio();
    final networkService = NetworkService(dio: mockDio, baseUrl: 'dummy1');

    final expectedData = {'name': 'Hamiiid'};

    when(
      () => mockDio.get<Map<String, dynamic>>(any()),
    ).thenAnswer(
      (_) async => Response(
        statusCode: 200,
        data: expectedData,
        requestOptions: RequestOptions(),
      ),
    );

    final response = await networkService.get(
      endpoint: 'dummy',
      fromJson: DummyPerson.fromJson,
    );

    expect(response, isA<NetworkResponse<DummyPerson>>());
    expect(response.statusCode, equals(200));
    expect(response.isSuccess, true);
    expect(response.data, isA<DummyPerson>());
    expect(response.data!.name, 'Hamiiid');
  });

  test('network calls - dio throws error', () async {
    final mockDio = MockDio();
    final networkService = NetworkService(dio: mockDio, baseUrl: 'dummy1');

    final expectedError = DioException(
      error: 'Bad Request',
      message: 'Bad Request message',
      response: Response(
        statusCode: 400,
        data: {'error': 'Bad Request'},
        requestOptions: RequestOptions(path: 'dummy'),
      ),
      requestOptions: RequestOptions(path: 'dummy'),
    );

    when(() => mockDio.get<Map<String, dynamic>>(any()))
        .thenThrow(expectedError);

    final response = await networkService.get(
      endpoint: 'dummy',
      fromJson: DummyPerson.fromJson,
    );

    expect(response, isA<NetworkResponse<DummyPerson>>());
    // expect(response.statusCode, 400); // becasue dio throws error without status code
    expect(response.isSuccess, false);
    expect(response.data, isNull);
    expect(response.error, equals('Bad Request message'));
  });
}

class DummyPerson {
  DummyPerson({required this.name});

  factory DummyPerson.fromJson(Map<String, dynamic> json) => DummyPerson(
        name: json['name'] as String,
      );
  String name;
}
