//
//  FlipsideViewController.m
//  AppStoreCash
//
//  Created by DougT on 2/21/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "FlipsideViewController.h"


@implementation FlipsideViewController

- (void)viewWillDisappear:(BOOL)animated // Called when the view is dismissed, covered or otherwise hidden. Default does nothing
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: [usernameField.text copy] forKey:@"Username"];
    [defaults setObject: [passwordField.text copy] forKey:@"Password"];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];     
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    usernameField.text = [defaults stringForKey:@"Username"];
    passwordField.text = [defaults stringForKey:@"Password"];
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
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // hide our text field
    [usernameField resignFirstResponder];
    [passwordField resignFirstResponder];

}

@end
