//
//  ViewController.h
//  MPEITimeTable
//
//  Created by Alex Noyanov on 28.08.17.
//  Copyright © 2017 Popoff Developer Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *editGroup;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)onLoadTimeTablePressed:(id)sender;
- (IBAction)onUpdateGroupPressed:(id)sender;

@end

