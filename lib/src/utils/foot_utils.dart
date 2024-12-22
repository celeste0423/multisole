class FootUtils {
  static String orderStatus(int isCompleted) {
    List<String> status = [
      '모델 생성중',
      '모델 제작 완료',
      '배송 준비중',
      '배송 완료',
    ];
    return status[isCompleted];
  }
}
