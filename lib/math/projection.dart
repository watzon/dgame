class Projection {

  double min, max;

  Projection(double min, double max) {
    this.min = min;
    this.max = max;
  }

  bool overlaps(Projection projection) {
    return this.max > projection.min && projection.max > this.min;
  }

  num getOverlap(Projection projection) {
    if (this.overlaps(projection)) {
         if (this.max > projection.max) {
            return projection.max - this.min;
         } else {
            return this.max - projection.min;
         }
      }

      return 0;
  }
}