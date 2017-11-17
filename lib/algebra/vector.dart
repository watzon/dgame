library dgame.algebra;

import 'dart:core';
import 'dart:math' as math;

class Vector {

  static Vector Zero  = new Vector(0, 0);

  static Vector One   = new Vector(1, 1);

  static Vector Half  = new Vector(0.5, 0.5);

  static Vector Up    = new Vector(0, -1);

  static Vector Down  = new Vector(0, 1);

  static Vector Left  = new Vector(-1, 0);

  static Vector Right = new Vector(1, 0);

  /// Takes an angle (in radians) and returns a new [Vector].
  static Vector fromAngle(double angle) {
    return new Vector(math.cos(angle), math.sin(angle));
  }

  /// Determines whether the given vector [vec] is valid or not. Returns a [bool].
  static bool isValid(Vector vec) {
    if (vec.x.isInfinite || vec.y.isInfinite || vec.x.isNaN || vec.y.isNaN) {
      return false;
    }

    return true;
  }

  /// Calculates the distance between [vec1] and [vec2].
  static double distance(Vector vec1, Vector vec2) {
    return math.sqrt(math.pow(vec1.x - vec2.x, 2) + math.pow(vec1.y - vec2.y, 2));
  }

  /// The [x], and [y] values of the [Vector].
  double x, y;

  Vector(x, y) {
    this.x = x.toDouble();
    this.y = y.toDouble();
  }

  Vector setTo(x, y) {
    this.x = x.toDouble();
    this.y = y.toDouble();
    return this;
  }

  /// Compares this [Vector] against another [vector] and tests for equality.
  bool equals(Vector vector, {double tolerance: 0.001}) {
    return (this.x - vector.x).abs() <= tolerance && (this.y - vector.y).abs() <= tolerance;
  }

  /// Gets the magnitude (size) of a the vector.
  double magnitude() {
    return Vector.distance(this, Vector.Zero);
  }

  /// Normalizes a [Vector] to have a magnitude of 1. Returns a new [Vector].
  Vector normalize() {
    double d = this.magnitude();
    if (d > 0) {
      return new Vector(this.x / d, this.y / d);
    } else {
      return Vector.Down;
    }
  }

  /// Returns the average of two [Vector]s.
  Vector average(Vector vec) {
    return this.add(vec).scale(0.5);
  }

  /// Scales a [Vector] by the [size] supplied and returns a new [Vector].
  Vector scale(double size) {
    return new Vector(this.x * size, this.y * size);
  }

  /// Adds two [Vectors], returning a new vector. (non-destructive)
  Vector add(Vector vec) {
    return new Vector(this.x + vec.x, this.y + vec.y);
  }

  /// Subtracts two [Vectors], returning a new vector. (non-destructive)
  Vector sub(Vector vec) {
    return new Vector(this.x - vec.x, this.y - vec.y);
  }

  /// Adds two [Vector]s, modifying the original.
  Vector addEqual(Vector vec) {
    this.x += vec.x;
    this.y += vec.y;
    return this;
  }

  /// Subtracts two [Vector]s, modifying the original.
  Vector subEqual(Vector vec) {
    this.x -= vec.x;
    this.y -= vec.y;
    return this;
  }

  /// Scales a [Vector] by the [size] supplied, modifying it.
  Vector scaleEqual(double size) {
    this.x *= size;
    this.y *= size;
    return this;
  }

  /// Performs the dot product with another [Vector].
  double dot(Vector vec) {
    return this.x * vec.x + this.y * vec.y;
  }

  /// Performs a 2D cross product with [double], returns a [Vector].
  Vector scalarCross(double scalar) {
    return new Vector(scalar * this.y, - scalar * this.x);
  }

  /// Performs a 2D cross product with [double], returns a [Vector].
  double cross(Vector vec) {
    return this.x * vec.y - this.y * vec.x;
  }

  /// Returns a new [Vector] perpendicular to this one.
  Vector perpendicular() {
    return new Vector(this.y, -this.x);
  }

  /// Returns the normal [Vector] perpendicular to this one.
  Vector normal() {
    return this.perpendicular().normalize();
  }

  /// Negates a [Vector].
  Vector negate() {
    return this.scale(-1.0);
  }

  /// Returns the angle of this [Vector] (in radians).
  double toAngle() {
    return math.atan2(this.y, this.x);
  }

  /// Rotates the current [Vector] around a point by a certain
  /// number of degrees in radians.
  Vector rotate(double angle, [Vector anchor]) {
    if (anchor == null) {
      anchor = Vector.Zero;
    }

    double sinAngle = math.sin(angle);
    double cosAngle = math.cos(angle);
    double x = cosAngle * (this.x - anchor.x) - sinAngle * (this.y - anchor.y) + anchor.x;
    double y = sinAngle * (this.x - anchor.x) + cosAngle * (this.y - anchor.y) + anchor.y;
    return new Vector(x, y);
  }

  /// Returns a clone of the current [Vector].
  Vector clone() {
    return new Vector(this.x, this,y);
  }

  /// Returns a stringified version of the vector for debugging.
  String toString() {
    return "(${this.x}, ${this.y})";
  }
}