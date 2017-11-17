import './math/vector.dart';

/// Possible collision resolution strategies.
/// 
/// The default, [CollisionResolutionStrategy.Box] performs simple axis aligned acrade style physics.
/// 
/// The more advanced rigid body physics are enabled by setting [CollisionResolutionStrategy.RigidBody]
/// which allows for complicated simulated physical interactions.
enum CollisionResolutionStrategy {
  Box,
  RigidBody,
}

/// Possible broadphase collision pair identification strategies
/// 
/// The default strategy is [BroadphaseStrategy.DynamicAABBTree] which uses a binary tree of axis-aligned
/// bounding boxes to identify potential collision pairs which is O(nlog(n)) faster. The other possible
/// strategy is the [BroadphaseStrategy.Naive] strategy which loops over every object for every
/// object in the scene to identify collision pairs which is O(n^2) slower.
enum BroadphaseStrategy {
  Naive,
  DynamicAABBTree
}

/// Possible numerical integrators for position and velocity
enum Integrator {
  Euler
}

/// The [Physics] object is the global configuration for all DGame physics.
class Physics {

  /// Global acceleration that is applied to all vanilla actors (it wont effect [Label|labels], [UIActor|ui actors], or
  /// [Trigger|triggers] in DGame that have an [CollisionType.Active|active] collision type).
  static Vector acc = Vector.Zero;

  /// Globaly switches all pysics on or off.
  static bool enabled = true;

  /// Sets the number pf collision passes for DGame to perform on physics bodies.
  /// 
  /// Reducing collision passes may cause things to not collide as expected, but may increse performance.
  /// 
  /// More passes can improve on the visual quality of collisions. This can reduce jitter, improve collision
  /// resolution of fast moving objects, or the stability of large numbers of object stacked together.
  /// 
  /// The default is set to 5 passes, which is a good start.
  static int collisionPasses = 5;

  /// Gets or sets the proadphase pair identification strategy.
  /// 
  /// The default strategy is [BroadphaseStrategy.DynamicAABBTree] which uses a binary tree of axis-aligned
  /// bounding boxes to identify potential collision pairs which is 0(nlog(n)) faster. The other possible 
  /// strategy is [BroadphaseStrategy.Naive] which loops over every object in the scene to check
  /// collisions and is 0(n^2) slower.
  static BroadphaseStrategy broadphaseStrategy = BroadphaseStrategy.DynamicAABBTree;

  /// Globally switches the debug information on or off for the broadphase strategy.
  static bool broadphaseDebug = false;

  /// Shoe the normals as a result of a collision on the screen.
  static bool showCollisionNormals = false;

  /// Show the position, velocity, and acceleration as graphical vectors.
  static bool showMotionVectors = false;
  
  /// Show the axis-aligned bounding boxes of the collision bodies on the screen.
  static bool showBounds = false;
   
  /// Show the bounding collision area shapes
  static bool showArea = false;
  
  /// Show points of collision interpreted by excalibur as a result of collision.
  static bool showContacts = false;
  
  /// Show the surface normals of the collision areas.
  static bool  showNormals = false;

  /// Gets or sets the global collision resolution strategy (narrowphase).
  /// 
  /// The default is [CollisionResolutionStrategy.Box], which performs simple axis-aligned arcade-style physics.
  /// 
  /// The more advanced [CollisionResolutionStrategy.Rigidbody] allows for complex simulated physical interations,
  /// at the expense of being more resource intensive.
  static CollisionResolutionStrategy collisionResolutionStrategy = CollisionResolutionStrategy.Box;

  /// Default mass to use if none is specified.
  static num defaultMass = 10;

  /// Gets or sets the position and velocity positional integrator, currently only [Integrator.Euler] is supported.
  static Integrator integrator = Integrator.Euler;

  /// The number of steps to use in an integration. A higher number improves the possitional acccuracy over time.
  /// This can be useful if you have fast moving objects in your simulation, or if you have a large number
  /// of objects and need to increse stability.
  static int integrationSteps = 1;

  /// Gets or sets whether rotation is allowed in a rigid body collision resolution.
  static bool allowRigidBodyRotation = true;

  /// Configures DGame to use box physics. Box physics perform simple axis-aligned arcade-style physics.
  /// 
  /// See [CollisionResolitionStrategy.Box]
  static useBoxPhysics() {
    Physics.collisionResolutionStrategy = CollisionResolutionStrategy.Box;
  }

  /// Configures DGame to use rigid body physics. Rigid body allows for more complicated simulated physical interactions.
  /// 
  /// See [CollisionResolitionStrategy.RigidBody]
  static useRigidBodyPhysics() {
    Physics.collisionResolutionStrategy = CollisionResolutionStrategy.RigidBody;
  }

  /// Small value to help collision passes settle themselves after the narrowphase.
  static num collisionShift = 0.001;

  /// Factor to add to the RigidBody BoundingBox, bounding box = (dimensions += vel * dynamicTreeVelocityMultiplier).
  static num dynamicTreeVelocityMultiplier = 2;

  /// Pad RigidBody BoundingBox by a constant amount
  static num boundsPadding = 5;

  /// Surface epsilon is used to help deal with surface penatration
  static num surfaceEpsilon = 0.1;

  /// Enable fast moving body checking, this enables checking for collision pairs via raycast for fast moving
  /// objects to prevent bodies from tunneling through one another.
  static bool checkForFastBodies = true;

  /// Disable minimum fast moving body raycast, by default if ex. `Physics.checkForFastBodies = true` DGame will only
  /// check if the body is moving at least half of its minimum diminension in an update.
  /// If ex. `Physics.disableMinimumSpeedForFastBody` is set to true, DGame will
  /// always perform the fast body raycast regardless of speed. 
  static bool disableMinimumSpeedForFastBody = false;
}