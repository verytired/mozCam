#pragma once

#include "ofxiOS.h"
#include "ofxiOSExtras.h"

#include "ofxGui.h"
#include "ofxOpenCv.h"

class testApp : public ofxiOSApp{
	
    public:
        void setup();
        void update();
        void draw();
        void exit();
	
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);

        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);

        void savePic();
        void drawCamView();

		ofImage img;

		#ifdef USE_CAMERA
			ofVideoGrabber grabber;
		#endif

		ofTexture tex;
		unsigned char * pix;

		ofxCvColorImage* colorCv;
		ofxCvColorImage colorCvHorizontal;
		ofxCvColorImage colorCvVertical;

        ofxCvColorImage* colorCvSmall;
        ofxCvColorImage colorCvSmallVertical;
		ofxCvColorImage colorCvSmallHorizontal;

		ofxCvGrayscaleImage* grayCv;
		ofxCvGrayscaleImage grayCvVertical;
		ofxCvGrayscaleImage grayCvHorizontal;
		ofxCvHaarFinder finder;

		ofImage colorImg;

		vector<ofxCvBlob> faces;
    
        //gui
        ofxPanel gui;
        ofParameter<int> size;
        ofSoundPlayer ring;

};


