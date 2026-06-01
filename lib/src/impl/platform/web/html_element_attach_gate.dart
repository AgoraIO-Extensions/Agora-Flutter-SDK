import 'dart:async';
import 'dart:html' as html;

// ignore_for_file: public_member_api_docs

typedef HtmlElementAttachObserverFactory = HtmlElementAttachObserver Function(
  void Function() onElementMayBeAttached,
);

abstract class HtmlElementAttachObserver {
  void observe(html.Element element);

  void disconnect();
}

class ResizeHtmlElementAttachObserver implements HtmlElementAttachObserver {
  ResizeHtmlElementAttachObserver(void Function() onElementMayBeAttached)
      : _observer = html.ResizeObserver((entries, observer) {
          onElementMayBeAttached();
        });

  final html.ResizeObserver _observer;

  @override
  void observe(html.Element element) {
    _observer.observe(element);
  }

  @override
  void disconnect() {
    _observer.disconnect();
  }
}

class HtmlElementAttachGate {
  HtmlElementAttachGate(
    this.element, {
    HtmlElementAttachObserverFactory createObserver = _defaultCreateObserver,
  }) {
    _completeIfAttached();
    if (!_attachedElementCompleter.isCompleted) {
      _observer = createObserver(_completeIfAttached);
      _observer!.observe(element);
      Timer.run(_completeIfAttached);
    }
  }

  final html.HtmlElement element;

  final _attachedElementCompleter = Completer<html.HtmlElement?>();

  html.HtmlElement? get attachedElementOrNull =>
      _attachedElementCompleter.isCompleted ? element : null;

  HtmlElementAttachObserver? _observer;
  bool _isDisposed = false;

  bool get isDisposed => _isDisposed;

  Future<html.HtmlElement?> get attachedElement =>
      _attachedElementCompleter.future;

  void dispose() {
    if (_isDisposed) {
      return;
    }

    _isDisposed = true;
    _observer?.disconnect();
    _observer = null;
    if (!_attachedElementCompleter.isCompleted) {
      _attachedElementCompleter.complete(null);
    }
  }

  void _completeIfAttached() {
    if (_isDisposed ||
        _attachedElementCompleter.isCompleted ||
        element.isConnected != true) {
      return;
    }

    _observer?.disconnect();
    _observer = null;
    _attachedElementCompleter.complete(element);
  }

  static HtmlElementAttachObserver _defaultCreateObserver(
    void Function() onElementMayBeAttached,
  ) {
    return ResizeHtmlElementAttachObserver(onElementMayBeAttached);
  }
}
