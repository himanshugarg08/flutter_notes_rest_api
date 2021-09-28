part of scalify;

const kDefaultHeight = 2.0;
const kDefaultWidth = 2.0;

class VerticalSpacing extends StatelessWidget {
  final double of;

  const VerticalSpacing({Key? key, this.of = kDefaultHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Scalify.getHeight(of),
    );
  }
}

class HorizontalSpacing extends StatelessWidget {
  final double of;

  const HorizontalSpacing({Key? key, this.of = kDefaultWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Scalify.getWidth(of),
    );
  }
}
