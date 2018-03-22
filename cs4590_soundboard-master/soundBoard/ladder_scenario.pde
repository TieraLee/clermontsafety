class LadderScenario {

  float
    direction, // angle of pedestrian approach
    distance; // distance of pedestrian in ft

  String filename1 = "outsideGoat.wav";

  boolean playing = false; //flag for when goat sample is playing

  SamplePlayer sp1;
  Button ladderButton;
  Slider slider;
  Knob knob;
  RadioButton crowdDensity;
  Panner pan; //to indicate direction

  Glide rate;
  Gain gain;

  LadderScenario(ControlP5 cp5, AudioContext ac) {
    rate = new Glide(ac, 1);

    //for panner
    pan = new Panner(ac, 0);
    pan.setPos(0);

    knob = p5.addKnob("knobValue")
      .setRange(0, 359)
      .setValue(0)
      .setPosition(250, 450)
      .setRadius(50)
      .setNumberOfTickMarks(10)
      .setTickMarkLength(4)
      .snapToTickMarks(false)
      .setColorForeground(color(255))
      .setColorBackground(color(0, 160, 100))
      .setColorActive(color(255, 255, 0))
      .setDragDirection(Knob.VERTICAL);

    ladderButton = cp5
      .addButton("Ladder_Alert")
      .setPosition(0, 400)
      .setSize(100, 25);

    slider = cp5.addSlider("distance")
      .setPosition(110, 400)
      .setRange(0.0, 10.0)
      .setValue(10)
      .setHeight(25);

    crowdDensity = cp5
      .addRadioButton("radioButton")
      .setPosition(50, 470)
      .setSize(40,20)
      .setColorLabel(color(255))
      .setItemsPerRow(1)
      .setSpacingColumn(50)
      .addItem("1", 1)
      .addItem("2", 1)
      .addItem("3", 1);

    CallbackListener ladderButtonHandler = new CallbackListener() {
      public void controlEvent(CallbackEvent event) {
        switch(event.getAction()) {
          case (ControlP5.ACTION_CLICK):  //NOTE: need to click button for sound to change
            //use playing boolean to ensure sample stops and plays correctly
            //with each button press
            if (playing) { 
              sp1.setToLoopStart();
              sp1.start();
              playing = false;
            }
            else {
              sp1.pause(true);
              playing = true;
            }
            break;
        }
      }
    };

    CallbackListener knobHandler = new CallbackListener() {
      public void controlEvent(CallbackEvent event) {
        direction = knob.getValue();
        // control pan based on angle here
        if((direction >= 0 && direction <= 89)){
          pan.setPos((float)(1-direction/90));
        }
        else if(direction >= 270 && direction <= 359){
          pan.setPos((float)((direction-270)/90));
        }
        else if(direction >= 90 && direction <= 179){
          pan.setPos((float)(-1)*((direction-90)/90));
        }
        else if(direction >= 180 && direction <= 269){
          pan.setPos((float)(-1)*(1-(direction-180)/90));
        }
     }
    };

    CallbackListener sliderHandler = new CallbackListener() {
      public void controlEvent(CallbackEvent event) {
        float scaledDist;

        distance = slider.getValue();
        scaledDist = distance > 5 ? 3 - (distance - 5) / 2.5 : 3;
        rate.setValue(scaledDist);
      }
    };

    ladderButton.addCallback(ladderButtonHandler);
    knob.addCallback(knobHandler);
    slider.addCallback(sliderHandler);

    sp1 = getSamplePlayer(filename1);
    sp1.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
    sp1.setRate(rate);
    sp1.pause(true);

    gain = new Gain(ac, 1, 0.2);
    gain.addInput(sp1);

    //ac.out.addInput(gain);

    //for panning
    pan.addInput(gain);
    ac.out.addInput(pan);
  };

  void updateCrowdDensity() {
    boolean
      one = crowdDensity.getState("1"),
      two = crowdDensity.getState("2"),
      threePlus = crowdDensity.getState("3");

    if (one)
      gain.setGain(0.1);
    else if (two)
      gain.setGain(0.2);
    else if (threePlus)
      gain.setGain(0.5);
  }
}
