#include "testApp.h"

#include "MyGuiViewController.h" //add
MyGuiViewController * myGuiViewController; //add

//--------------------------------------------------------------
void testApp::setup() {

    ofxiOSSetOrientation(OF_ORIENTATION_DEFAULT);
    //検分器の読み込み
    finder.setup("haarcascade_frontalface_default.xml");

    #ifdef USE_CAMERA
        //カメラセッティング
		ofSetFrameRate(20);
		grabber.setDesiredFrameRate(20);
		grabber.initGrabber(ofGetWidth(), ofGetHeight());

		int w = grabber.getWidth();
		int h = grabber.getHeight();

        colorCvVertical.allocate(w,h);
        colorCvHorizontal.allocate(h,w);

        colorCvSmallVertical.allocate(w/4, h/4);
		colorCvSmallHorizontal.allocate(h/4, w/4);

		grayCvVertical.allocate(w/4, h/4);
		grayCvHorizontal.allocate(h/4, w/4);

        colorCv=&colorCvVertical;
        colorCvSmall=&colorCvSmallVertical;
        grayCv=&grayCvVertical;

        //検分器の設定
		finder.setNeighbors(1);
		finder.setScaleHaar(1.5);
	#else
        //カメラ使わない場合は画像読み込み
        img.loadImage("test.jpg");
    #endif

    camera = new ofxiOSImagePicker();
    camera->setMaxDimension(480);

    //gui settings
    ofxGuiSetTextPadding(4);
    ofxGuiSetDefaultWidth(300);
    ofxGuiSetDefaultHeight(18);
    gui.setup("mosaic");
    ofxGuiSetDefaultHeight(30);
    gui.add(size.set( "size", 20, 1, 30));
    gui.setPosition(10, 380);
    ring.loadSound("ring.wav");

    myGuiViewController =[[MyGuiViewController alloc] init];
    [ofxiOSGetGLView() addSubview:myGuiViewController.view];
}

//--------------------------------------------------------------
void testApp::update() {
    ofBackground(255, 255, 255);

    #ifdef USE_CAMERA
		grabber.update();
         *colorCv = grabber.getPixels();

        ofxCvColorImage tempCv= *colorCvSmall;
        tempCv.scaleIntoMe(*colorCv, CV_INTER_NN);

        *grayCv = tempCv;
		finder.findHaarObjects(*grayCv);
		faces = finder.blobs;

	#else
        //we don't really need to do this every frame
        //but it simulates closer what the camera demo would be doing
        finder.findHaarObjects(img);
    #endif

    //検出した顔情報の配列
    faces = finder.blobs;
}

//--------------------------------------------------------------
void testApp::draw() {

    ofSetColor(255);
    drawCamView();
    ofEnableAlphaBlending();
    ofSetColor(230, 0, 255, 200);
    ofRect(0, 0, ofGetWidth(), 16);
    ofSetColor(255, 255, 255);
    ofDrawBitmapString("face detector :: covered with a mosaic", 5, 12);
    gui.draw();
}

void testApp::drawCamView(){
    float scaleFactor = 1.0;

    #ifdef USE_CAMERA
        grabber.draw(0, 0);
        scaleFactor = 4.0;
        ofxCvColorImage img;
        img.allocate(grabber.width, grabber.height);
        img = grabber.getPixels();
        unsigned char *pixels = img.getPixels();

        int w = img.width;
        int h = img.height;

        //set mosaic
        int skip = size;
        for (int k = 0; k < faces.size(); k++) {
            ofRectangle rect(faces[k].boundingRect.x * scaleFactor, faces[k].boundingRect.y * scaleFactor, faces[k].boundingRect.width * scaleFactor, faces[k].boundingRect.width * scaleFactor);
            for (int j = rect.y; j < rect.y + rect.height; j += skip) {
                for (int i = rect.x; i < rect.x + rect.width; i += skip) {
                    int valueR = pixels[j * w + i];
                    int valueG = pixels[j * w + i + 1];
                    int valueB = pixels[j * w + i + 2];
                    ofSetColor(valueR, valueG, valueB);
                    ofRect(i, j, skip, skip);
                }
            }
        }

    #else
        img.draw(0, 0);
    #endif
}
//--------------------------------------------------------------
void testApp::exit() {

}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs & touch) {

}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs & touch) {

}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs & touch) {

}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs & touch) {

}

//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs& touch) {

}

//--------------------------------------------------------------
void testApp::lostFocus() {

}

//--------------------------------------------------------------
void testApp::gotFocus() {

}

//--------------------------------------------------------------
void testApp::gotMemoryWarning() {

}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation) {
    cout << "orientation = " << newOrientation << endl;


    //todo do not rotation now
    /*
   if(newOrientation==5)
       return;
   ofSetOrientation((ofOrientation)newOrientation);
   grabber.initGrabber(ofGetWidth(), ofGetHeight());
   switch(newOrientation){
       case 1:
       case 2:
           colorCv=&colorCvVertical;
           colorCvSmall=&colorCvSmallVertical;
           grayCv=&grayCvVertical;
           gui.setPosition(10, 420);
           break;
       case 3:
       case 4:
           colorCv=&colorCvHorizontal;
           colorCvSmall=&colorCvSmallHorizontal;
           grayCv=&grayCvHorizontal;
           gui.setPosition(10, 200);
           break;
   }
   */

}

void testApp::savePic(){
    cout << "savePic" << endl;
    drawCamView();
    ring.play();
    ofSaveScreen("capture image");
    camera->saveImage();
    ofxiOSScreenGrab(NULL);
}
