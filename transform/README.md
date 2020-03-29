# transform

```dart
Widget build(BuildContext context) {
    return Transform(
        transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(0.1 * _offset.dy)
            ..rotateY(0.1 * _offset.dx),
        alignment: Alignment.center,
        child: GestureDetector(
            onPanUpdate: (details) {
                setState(() {
                    _offset += details.delta;
                });
            },
            onDoubleTap: () => setState(() => _offset = Offset.zero),
            child: _defaultApp(context),
        ),
    );
}
```