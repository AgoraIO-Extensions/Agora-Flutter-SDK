typedef TesterArgsProvider = Object Function(Object apiEngineHandle);

abstract class IrisTester {
  void initialize();

  List<TesterArgsProvider> getTesterArgs();

  void dispose();

  void expectCalled(String funcName, String params);

  bool fireEvent(String eventName, {Map params = const {}});
}
