import controlP5.*;
import beads.*;
import org.jaudiolibs.beads.*;
import java.util.concurrent.TimeUnit;
import java.lang.Math;
//declare global variables at the top of your sketch
//AudioContext ac; is declared in helper_functions

SamplePlayer heartbeatSound;
SamplePlayer flatlineSound;

SamplePlayer a_yellow;
SamplePlayer a_yellowSlow;
SamplePlayer a_yellowFast;
SamplePlayer a_yellowFaster;

SamplePlayer b_green;
SamplePlayer b_greenSlow;
SamplePlayer b_greenFast;
SamplePlayer b_greenFaster;

SamplePlayer c_black;
SamplePlayer c_blackSlow;
SamplePlayer c_blackFast;
SamplePlayer c_blackFaster;

SamplePlayer d_red;
SamplePlayer d_redSlow;
SamplePlayer d_redFast;
SamplePlayer d_redFaster;

SamplePlayer e_white;
SamplePlayer e_whiteSlow;
SamplePlayer e_whiteFast;
SamplePlayer e_whiteFaster;

SamplePlayer[] voltageArray = new SamplePlayer[20];

SamplePlayer current = voltageArray[0]; // initialization purposes
boolean isCurrent = false;

Button heartbeat;
Button flatline;
RadioButton voltages;


Textlabel currentVolumeLabel;
Slider slider;

Slider voltageSlider;
Glide gainGlide;
Gain g3;
Gain g4;
Gain voltageArrayGain;

ControlP5 p5;
int backgroundColor;

//class for more advanced ladder scenario
//NOTE: need to click LADDER_ALERT button again to hear a different sound
LadderScenario ladderScenario;

//end global variables

void setup() {
  size(600, 600); //size(width, height) must be the first line in setup()
  ac = new AudioContext(); //AudioContext ac; is declared in helper_functions

  flatlineSound = getSamplePlayer("flatline.mp3");
  flatlineSound.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  flatlineSound.pause(true);
  g3 = new Gain(ac, 1, gainGlide); //create gain object and attach glide
  g3.addInput(flatlineSound); //connect our sound to gain input

  heartbeatSound = getSamplePlayer("heartRateMonitor.mp3");
  heartbeatSound.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  heartbeatSound.pause(true);
  g4 = new Gain(ac, 1, gainGlide); //create gain object and attach glide
  g4.addInput(heartbeatSound); //connect our sound to gain input

  voltageArrayGain = new Gain(ac,1,gainGlide);

  a_yellowSlow = getSamplePlayer("a-yellow-slow.wav");
  a_yellowSlow.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  a_yellowSlow.pause(true);
  voltageArrayGain.addInput(a_yellowSlow);
  voltageArray[0] = a_yellowSlow;

  a_yellow = getSamplePlayer("a-yellow.wav");
  a_yellow.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  a_yellow.pause(true);
  voltageArrayGain.addInput(a_yellow);
  voltageArray[1] = a_yellow;

  a_yellowFast = getSamplePlayer("a-yellow-fast.wav");
  a_yellowFast.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  a_yellowFast.pause(true);
  voltageArrayGain.addInput(a_yellowFast);
  voltageArray[2] = a_yellowFast;

  a_yellowFaster = getSamplePlayer("a-yellow-faster.wav");
  a_yellowFaster.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  a_yellowFaster.pause(true);
  voltageArrayGain.addInput(a_yellowFaster);
  voltageArray[3] = a_yellowFaster;

  b_greenSlow = getSamplePlayer("b-green-slow.wav");
  b_greenSlow.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  b_greenSlow.pause(true);
  voltageArrayGain.addInput(b_greenSlow);
  voltageArray[4] = b_greenSlow;

  b_green = getSamplePlayer("b-green.wav");
  b_green.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  b_green.pause(true);
  voltageArrayGain.addInput(b_green);
  voltageArray[5] = b_green;

  b_greenFast = getSamplePlayer("b-green-fast.wav");
  b_greenFast.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  b_greenFast.pause(true);
  voltageArrayGain.addInput(b_greenFast);
  voltageArray[6] = b_greenFast;

  b_greenFaster = getSamplePlayer("b-green-faster.wav");
  b_greenFaster.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  b_greenFaster.pause(true);
  voltageArrayGain.addInput(b_greenFaster);
  voltageArray[7] = b_greenFaster;

  c_blackSlow = getSamplePlayer("c-black-slow.wav");
  c_blackSlow.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  c_blackSlow.pause(true);
  voltageArrayGain.addInput(c_blackSlow);
  voltageArray[8] = c_blackSlow;

  c_black = getSamplePlayer("c-black.wav");
  c_black.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  c_black.pause(true);
  voltageArrayGain.addInput(c_black);
  voltageArray[9] = c_black;

  c_blackFast = getSamplePlayer("c-black-fast.wav");
  c_blackFast.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  c_blackFast.pause(true);
  voltageArrayGain.addInput(c_blackFast);
  voltageArray[10] = c_blackFast;

  c_blackFaster = getSamplePlayer("c-black-faster.wav");
  c_blackFaster.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  c_blackFaster.pause(true);
  voltageArrayGain.addInput(c_blackFaster);
  voltageArray[11] = c_blackFaster;

  d_redSlow = getSamplePlayer("d-red-slow.wav");
  d_redSlow.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  d_redSlow.pause(true);
  voltageArrayGain.addInput(d_redSlow);
  voltageArray[12] = d_redSlow;

  d_red = getSamplePlayer("d-red.wav");
  d_red.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  d_red.pause(true);
  voltageArrayGain.addInput(d_red);
  voltageArray[13] = d_red;

  d_redFast = getSamplePlayer("d-red-fast.wav");
  d_redFast.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  d_redFast.pause(true);
  voltageArrayGain.addInput(d_redFast);
  voltageArray[14] = d_redFast;

  d_redFaster = getSamplePlayer("d-red-faster.wav");
  d_redFaster.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  d_redFaster.pause(true);
  voltageArrayGain.addInput(d_redFaster);
  voltageArray[15] = d_redFaster;

  e_whiteSlow = getSamplePlayer("e-white-slow.wav");
  e_whiteSlow.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  e_whiteSlow.pause(true);
  voltageArrayGain.addInput(e_whiteSlow);
  voltageArray[16] = e_whiteSlow;

  e_white = getSamplePlayer("e-white.wav");
  e_white.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  e_white.pause(true);
  voltageArrayGain.addInput(e_white);
  voltageArray[17] = e_white;

  e_whiteFast = getSamplePlayer("e-white-fast.wav");
  e_whiteFast.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  e_whiteFast.pause(true);
  voltageArrayGain.addInput(e_whiteFast);
  voltageArray[18] = e_whiteFast;

  e_whiteFaster = getSamplePlayer("e-white-faster.wav");
  e_whiteFaster.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  e_whiteFaster.pause(true);
  voltageArrayGain.addInput(e_whiteFaster);
  voltageArray[19] = e_whiteFaster;

  p5 = new ControlP5(this);

  ladderScenario = new LadderScenario(p5, ac);

  ac.out.addInput(g3);
  ac.out.addInput(g4);
  ac.out.addInput(voltageArrayGain);

  ac.start();

  //CONTROL P5

  heartbeat = p5.addButton("Heartbeat")
     .setPosition(0, 300)
     .setSize(100,25);

  flatline = p5.addButton("Flatline")
    .setPosition(0, 326)
    .setSize(100, 25);

    voltages = p5.addRadioButton("wireVoltages")
      .setPosition(0,50)
      .setSize(40,20)
      .setItemsPerRow(4)
      .setSpacingColumn(75)
      .addItem("yellow_240-399",0)
      .addItem("yellow_400-479",1)
      .addItem("yellow_480-599",2)
      .addItem("yellow_600+",3)
      .addItem("green_240-399",4)
      .addItem("green_400-479",5)
      .addItem("green_480-599",6)
      .addItem("green_600+",7)
      .addItem("black_240-399",8)
      .addItem("black_400-479",9)
      .addItem("black_480-599",10)
      .addItem("black_600+", 11)
      .addItem("red_240-399",12)
      .addItem("red_400-479",13)
      .addItem("red_480-599",14)
      .addItem("red_600+", 15)
      .addItem("white_240-399",16)
      .addItem("white_400-479",17)
      .addItem("white_480-599",18)
      .addItem("white_600+", 19);

   voltageSlider = p5.addSlider("Voltage")
     .setPosition(0,274)
     .setRange(120,480)
     .setValue(10)
     .setHeight(25);
}

void draw() {
  background(backgroundColor);

  text("The color refers to the wire color",300,200);
  text("The range refers to the voltage range",300,225);
  text("IF there is no voltage on any wire: flatline", 300,250);

  text("number of people in range", 20, 460);

   //***************
   heartbeatSound.setRate(new Glide(ac, (float)(voltageSlider.getValue() / 100)));
   if (heartbeat.isPressed()) {
     if(isCurrent) {
       current.pause(true);
     }
      flatlineSound.pause(true);
      heartbeatSound.setToLoopStart();
      heartbeatSound.start();
   }
   if(flatline.isPressed()) {
     if(isCurrent) {
       current.pause(true);
     }
     heartbeatSound.pause(true);
      flatlineSound.setToLoopStart();
      flatlineSound.start();
   }
}

void pauseProgram(int secs) {
  try {
    Thread.sleep(secs);
  } catch(Exception e) {
    System.out.println("An Exception Occured!!");
  }
}

 //plays sounds in  voltage array
void controlEvent(ControlEvent theEvent) {
  if(theEvent.isFrom(voltages)) {
    if (isCurrent) {
      current.pause(true);
    }

    heartbeatSound.pause(true);
    flatlineSound.pause(true);

    int value = Math.round(theEvent.getGroup().getValue());
    SamplePlayer newSound = voltageArray[value];
    newSound.setToLoopStart();
    newSound.start();
    isCurrent= true;
    current = newSound;
  }

  if (ladderScenario != null && theEvent.isFrom(ladderScenario.crowdDensity))
    ladderScenario.updateCrowdDensity();
}

SamplePlayer getCurrentSamplePlayer(int i) {
  return voltageArray[i];
}
