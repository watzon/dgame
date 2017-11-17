import 'dart:math' as math;
import './vector.dart';

class Line {

  Vector begin;
  Vector end;

  Line(Vector begin, Vector end) {
    this.begin = begin;
    this.end = end;
  }

  /// Gets the raw slope (m) of the [Line]. Will return (+/-)Infinity for vertical [Line]s.
  double get slope {
    return (this.end.y - this.begin.y) / (this.end.x - this.begin.x);
  }

  /// Gets the Y-intercept (b) of the [Line]. Will return (+/-)Infinity if there is no intercept.
  double get inercept {
    return this.begin.y - (this.slope * this.begin.x);
  }

  /// Returns the slope of the [Line] in the form of a [Vector]
  Vector getSlope() {
    // TODO: Refactor this logic into a private method since it get's used
    // in getLength as well.
    Vector begin = this.begin;
    Vector end = this.end;
    double distance = Vector.distance(begin, end);
    return end.sub(begin).scale(1 / distance);
  }

  /// Returns the length of the [Line] segment in pixels
  double getLength() {
    Vector begin = this.begin;
    Vector end = this.end;
    double distance = Vector.distance(begin, end);
    return distance;
  }

  Vector findPoint({double x: null, double y: null}) {
    double m = this.slope;
    double b = this.inercept;

    if (x != null) {
      return new Vector(x, (m * x) + b);
    } else if (y != null) {
      return new Vector((y - b) / m, y);
    } else {
      throw new ArgumentError('A value must be supplied for either x or y');
    }
  }

  /// 
  bool hasPoint(x, [y, threshold = 0]) {
    Vector currPoint;

    if (x is num && y is num) {
      currPoint = new Vector(x, y);
    } else {
      currPoint = x;
      threshold = y == null ? threshold : y;
    }

    double dxc = currPoint.x - this.begin.x;
    double dyc = currPoint.y - this.begin.y;

    double dx1 = this.end.x - this.begin.x;
    double dy1 = this.end.y - this.begin.y;

    double cross = dxc * dy1 - dyc * dx1;

    // Check whether point lies on the line
    if (cross.abs() >= dy1.abs()) {
      return false;
    }

    // check whether point lies in-between start and end
    if (dx1.abs() >= dy1.abs()) {
      if (dx1 > 0) {
        return this.begin.x <= currPoint.x && currPoint.x <= this.end.x;
      } else {
        return this.end.x <= currPoint.x && currPoint.x <= this.begin.x;
      }
    } else {
      if (dy1 > 0) {
        return this.begin.y <= currPoint.y && currPoint.y <= this.end.y;
      } else {
        this.end.y <= currPoint.y && currPoint.y <= this.begin.y;
      }
    }

    return false;
  }
}