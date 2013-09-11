//
// Created by sano on 2013/09/02.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MyGuiViewController.h"

@implementation MyGuiViewController

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
 */
-(id)init {
    [super init];

    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    //footer
    UIToolbar * toolBar = [ [ UIToolbar alloc ] initWithFrame:CGRectMake( 0, self.view.bounds.size.height - 44, 320, 44 ) ];
    UIBarButtonItem * btn1 = [ [ [ UIBarButtonItem alloc ] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector( onTapTest: ) ] autorelease ];
    UIBarButtonItem * flexibleSpacer = [ [ [ UIBarButtonItem alloc ] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil ] autorelease ];
    toolBar.items = [ NSArray arrayWithObjects:flexibleSpacer,btn1,flexibleSpacer,nil ];
    [ self.view addSubview:toolBar ];

    NSLog(@"loaded");
    myApp = (testApp*)ofGetAppPtr();
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/*撮影ボタン押下時ハンドラ*/
- ( void )onTapTest:( id )inSender{
    // ボタンを押された時の処理をここに追加
    NSLog(@"push button");
    myApp->savePic();

    return;
}

@end