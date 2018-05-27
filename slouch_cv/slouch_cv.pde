import fr.jcgay.notification.Application;
import fr.jcgay.notification.Icon;
import fr.jcgay.notification.Notification;
import fr.jcgay.notification.Notifier;
import fr.jcgay.notification.SendNotification;

import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;

float calHeight;
float lasty = 0;
float minWidth = 1000;
float lastWidth = 1000;

boolean hasYelled = false;
boolean hasYelledOK = true;

import java.net.URL;

void setup() {
  size(640, 480);
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  calHeight = height/2;
  video.start();
}
void draw() {
  scale(2);
  opencv.loadImage(video);

  image(video, 0, 0 );

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();
  //println(faces.length);
  
  lasty = 0;
  
  for (int i = 0; i < faces.length; i++) {
    //println(faces[i].x + "," + faces[i].y);
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    lastWidth = faces[i].width - 20;
    lasty = faces[i].y;
    //println(faces[i].width);
    if(faces[i].y > calHeight + 10 && !hasYelled && faces[i].width > minWidth) {
      if(!mousePressed) {
        //println("a", calHeight, lasty, hasYelled);
        yell("you are slouching!");
        hasYelled = true;
        hasYelledOK = false;
      }
    }
    if(faces[i].y < calHeight + 5 && faces[i].width > minWidth) {
      //println("b", calHeight, lasty, hasYelled);
      hasYelled = false;
      if(!hasYelledOK) {
        yell("You are no longer slouching.");
        hasYelledOK = true;
      }
    }
  }
  
  if(mousePressed) {
    calHeight = lasty;
    minWidth = lastWidth;
  }
  println(hasYelledOK);
}

void captureEvent(Capture c) {
  c.read();
}
