/*

 Example Processing sketch for Aesthetic code / Smart Things
 2017 Christopher von Nagy
 
 A sketch of a pinball game for Smart Things

*/

class Flipper {

  // Declare objects and variables
  RevoluteJoint joint;
  Circle circle;
  Poly poly;
  
  // Constructor
  Flipper(float x, float y, String chirality) {
    

    // Initialize locations of two boxes
    if (chirality == "r"){poly = new Poly(x, y, chirality, false);} else {poly = new Poly(x, y, chirality, false);}
    circle = new Circle(x, y, 2, true); 

    // Define joint as between two bodies
    RevoluteJointDef rjd = new RevoluteJointDef();
    Vec2 offset = box2d.vectorPixelsToWorld(new Vec2(0, 60));
    // rjd.initialize(box.body, circle.body, box.body.getWorldCenter());
    rjd.initialize(poly.body, circle.body, poly.body.getWorldCenter());

    // Set joint parameters
    //rjd.lowerAngle = PI;
    //rjd.upperAngle = 0.5*PI;
    if (chirality == "r"){rjd.motorSpeed = -PI*3;} else {rjd.motorSpeed = PI*3;}
    rjd.maxMotorTorque = 10000.0;
    rjd.enableMotor = true;


      // Create the joint
    joint = (RevoluteJoint) box2d.world.createJoint(rjd);
    
  }

  // Sound collision.
  void sound() {
    // Put sound code here
  }


  // Turn the motor on or off
  void toggleMotor() {
    //joint.enableMotor(!joint.isMotorEnabled());
    if (joint.getMotorSpeed() > 0.0 || joint.getMotorSpeed() < 0.0) {joint.setMotorSpeed(0);}
    else if (joint.getMotorSpeed() == 0.0) {joint.setMotorSpeed(10);}
  }

  boolean motorOn() {
    return joint.isMotorEnabled();
  }


  void display() {
    poly.display();
    circle.display();

    // Draw anchor
    Vec2 anchor = box2d.coordWorldToPixels(poly.body.getWorldCenter());
    fill(255, 0, 0);
    stroke(0);
    ellipse(anchor.x, anchor.y, 4, 4);
  }
}