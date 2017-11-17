library dgame.ray;

import 'dart:math' as math;
import './vector.dart';
import './line.dart';

class Ray {

  Vector pos;
  Vector dir;

  Ray(Vector pos, Vector dir) {
    this.pos = pos;
    this.dir = dir.normalize();
  }

  num intersect(Line line) {
    Vector numerator = line.begin.sub(this.pos);

    // Test if line and ray are parallel ond non intersecting
    if (this.dir.cross(line.getSlope()) == 0 && numerator.cross(this.dir) != 0) {
      return -1;
    }

    // Lines are parallel
    num divisor = (this.dir.cross(line.getSlope()));
    if (divisor == 0) {
      return -1;
    }

    num t = numerator.cross(line.getSlope()) / divisor;
    if (t >= 0) {
      num u = (numerator.cross(this.dir) / divisor) / line.getLength();
      if (u >= 0 && u <= 1) {
        return t;
      }
    }

    return -1;
  }

  Vector getPoint(num time) {
    return this.pos.add(this.dir.scale(time));
  }
}