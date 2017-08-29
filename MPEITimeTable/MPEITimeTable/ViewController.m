//
//  ViewController.m
//  MPEITimeTable
//
//  Created by Alex Noyanov on 28.08.17.
//  Copyright © 2017 Popoff Developer Studio. All rights reserved.
//

#import "ViewController.h"
#import "GroupDatabase.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"https://mpei.ru/Education/timetable/Pages/default.aspx"];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onLoadTimeTablePressed:(id)sender {
    NSString* groupName = self.editGroup.text;
    GroupDatabase* database = [GroupDatabase getInstance];
    NSString* groupId = [database groupNameToGroupId:groupName];
    if(groupId.length == 0)
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Ошибка"
                                                                       message:@"Неправильный номер группы!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
//        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
//                                                              handler:^(UIAlertAction * action) {}];
//        
//        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    [self loadGroup:groupId];
}

- (IBAction)onUpdateGroupPressed:(id)sender {
}

- (void) loadGroup:(NSString*)groupId
{
      NSURL* url = [NSURL URLWithString:@"https://mpei.ru/Education/timetable/Pages/table.aspx"];
      NSString *post = [NSString stringWithFormat: @"groupid=%@", groupId];
      NSData* postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
      NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
//
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setURL:url];
//    [request setHTTPMethod: @"POST"];
//    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [request setHTTPBody:postData];
//    
//    self.conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//    
//    [self.webView loadRequest:request];
    
    ///////
    
    NSError *error;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request addValue:postLength forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"Data=%@", data);
        NSLog(@"Error=%@", error);
        if(error == nil && data != nil) {
            NSString* html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"Html=%@", html);
            [self.webView loadHTMLString:html baseURL:url];
        }
    }];
    
    [postDataTask resume];
    
    
/*
    
    NSURL *url = [NSURL URLWithString: [@"https://mpei.ru/Education/timetable/Pages/table.aspx?groupid=" stringByAppendingString:groupId]];
    NSString *body = [NSString stringWithFormat: @"groupid=%@", groupId];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod: @"POST"];
    //[request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    [self.webView loadRequest: request];
*/
/*
    
    NSString *urlAddress = [@"https://mpei.ru/Education/timetable/Pages/table.aspx?groupid=" stringByAppendingString:groupId];
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [requestObj setHTTPMethod: @"POST"];
    [self.webView loadRequest:requestObj];
*/
}


//// This method is used to receive the data which we get using post method.
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data
//{
//    NSLog(@"Data=%@", data);
//}
//
//// This method receives the error report in case of connection is not made to server.
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
//{
//    NSLog(@"Error=%@", error);
//}
//
//// This method is used to process the data after connection has made successfully.
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection
//{
//    
//}

@end
