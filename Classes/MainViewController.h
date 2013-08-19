//
//  MainViewController.h
//  AppStoreCash
//
//  Created by DougT on 2/21/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UIWebViewDelegate> {
    IBOutlet UILabel *ourLabel;
    IBOutlet UIWebView *ourWebView;
    IBOutlet UIActivityIndicatorView *ourActivityView;
    int whichPage;
    NSString *username;
    NSString *password;

}

@end
