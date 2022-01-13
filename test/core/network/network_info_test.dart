import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:product_list/core/utils/network_info.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([Connectivity])
void main() {
  late final Connectivity mockConnectivity;
  late NetworkInfo sut;

  setUp(() {
    mockConnectivity = MockConnectivity();
    sut = NetworkInfo(connectionChecker: mockConnectivity);
  });

  group('isConnected', () {
    test('should return true while is connected', () async {
      // arrange
      final connectivityResultFuture = Future.value(ConnectivityResult.mobile);

      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => connectivityResultFuture);
      // act
      final actual = await sut.isConnected();
      // assert
      verify(mockConnectivity.checkConnectivity());
      expect(actual, true);
    });
  });
}
