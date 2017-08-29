//
//  ViewController.h
//  MPEITimeTable
//
//  Created by Alex Noyanov on 28.08.17.
//  Copyright © 2017 Popoff Developer Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <NSURLSessionDelegate>

@property (weak, nonatomic) IBOutlet UITextField *editGroup;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

//@property (strong, nonatomic) NSURLConnection *conn;
@property (strong, nonatomic) NSURLSessionConfiguration *configuration;
@property (strong, nonatomic) NSURLSession *session;
@property (strong, nonatomic) NSString *groupId;



- (IBAction)onLoadTimeTablePressed:(id)sender;
- (IBAction)onUpdateGroupPressed:(id)sender;

@end

