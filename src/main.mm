#include "testApp.h"
#include "ofMain.h"
//#include "ofAppiOSWindow.h"

int main(){
    //opegl es2.0を使う
    ofAppiOSWindow * window = new ofAppiOSWindow();
    window->enableRendererES2();

    window->enableHardwareOrientation();
    window->enableOrientationAnimation();

    ofSetupOpenGL(1024,768, OF_FULLSCREEN);			// <-------- setup the GL context
    ofRunApp(new testApp);
}
