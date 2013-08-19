//
//  MainViewController.m
//  AppStoreCash
//
//  Created by DougT on 2/21/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "MainViewController.h"
#import "AppStoreCashAppDelegate.h"

@implementation MainViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    printf("-->> %s\n", [[[webView.request URL] absoluteString] UTF8String]);
    if (whichPage == 0) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *u = [defaults stringForKey:@"Username"];
        NSString *p = [defaults stringForKey:@"Password"];
        
        NSString * str = @"";
        str = [str stringByAppendingFormat: @"document.appleConnectForm.theAccountName.value=\"%@\";", u];
        str = [str stringByAppendingFormat: @"document.appleConnectForm.theAccountPW.value=\"%@\";", p];
        str = [str stringByAppendingString: @"document.appleConnectForm.submit();"];
        
//        printf("-->> %s\n", [str UTF8String]);

        [webView stringByEvaluatingJavaScriptFromString: str];

    }
    else if (whichPage == 1)
    {
        NSURLRequest *aRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://itts.apple.com/cgi-bin/WebObjects/Piano.woa"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        [ourWebView loadRequest:aRequest];
    }
    else if (whichPage == 2)
    {
        NSString * str;
        str = @"document.frmVendorPage.selDateType.selectedIndex=3;handleSelDateType();";
        [webView stringByEvaluatingJavaScriptFromString: str];       
    }
    else if (whichPage == 3)
    {
        NSString * str;
        str = @"document.frmVendorPage.btnPreview.click();";
        [webView stringByEvaluatingJavaScriptFromString: str];
    }
    else if (whichPage == 4)
    {
        ourWebView.hidden = NO;
        ourActivityView.hidden = YES;
    }

    whichPage++;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
{
}

- (void)viewWillDisappear:(BOOL)animated // Called when the view is dismissed, covered or otherwise hidden. Default does nothing
{
    NSString * str;
    str = @"document.signOutForm.submit();";
    [ourWebView stringByEvaluatingJavaScriptFromString: str];   
    
    [super viewWillDisappear:animated];
}

- (void) gogoGadgetGears
{
    whichPage = 0;
    
    NSURLRequest *aRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://itunesconnect.apple.com"] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    [ourWebView loadRequest:aRequest];
    ourWebView.delegate = self;
    ourWebView.scalesPageToFit = YES;    
}

- (void) gotoSettingsView
{
    // switch to the other view so that the user can specify their uwer name and apssword.
    AppStoreCashAppDelegate *appDelegate = (AppStoreCashAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.rootViewController toggleView];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    username = [defaults stringForKey:@"Username"];
    password = [defaults stringForKey:@"Password"];
    
    if (username == nil || [username length] == 0 ||
        password == nil || [password length] == 0 )
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Configuration Error" message:@"You don't have a username configured. Please use the Settings to specify one." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    
        [NSTimer scheduledTimerWithTimeInterval:.2
                                         target:self
                                       selector:@selector(gotoSettingsView)
                                       userInfo:nil
                                        repeats:NO];
        return;
    }
    
    [self gogoGadgetGears];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    username = [defaults stringForKey:@"Username"];
    password = [defaults stringForKey:@"Password"];

    if (username == nil || [username length] == 0 ||
        password == nil || [password length] == 0 )
    {
        [NSTimer scheduledTimerWithTimeInterval:.2
                                         target:self
                                       selector:@selector(gotoSettingsView)
                                       userInfo:nil
                                        repeats:NO];
        return;
    }
    
    [self gogoGadgetGears];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;//(interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
    [username release];
    [password release];

}


@end
