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
    NSString* groupName = [self loadGroupName];
    self.editGroup.text = groupName;
    self.webView.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onLoadTimeTablePressed:(id)sender
{
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
    [self saveGroupName:groupName];
    [self loadGroupById:groupId];
}

- (IBAction)onUpdateGroupPressed:(id)sender
{
//    NSString *jsStat = @"document.getElementsByName('aspnetForm')[0].click()";
//    jsStat = @"document.getElementById('aspnetForm').click()";
//    NSString* res = [self.webView stringByEvaluatingJavaScriptFromString:jsStat];
//    NSLog(@"res=%@", res);
//    _shouldProcess = YES;
//    NSURL *url = [NSURL URLWithString:@"https://mpei.ru/Education/timetable/Pages/default.aspx"];
//    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
//    [self.webView loadRequest:requestObj];
    [self loadGroupByName:self.editGroup.text];
}

- (NSString*) getPostScript:(NSString*)html
{
    NSInteger begin = [html rangeOfString:@":__doPostBack("].location;
    if(begin != NSNotFound) {
        begin++;
        NSInteger end = [html rangeOfString:@"\"" options:0 range:NSMakeRange(begin, html.length-begin)].location;
        if(end != NSNotFound) {
            if(end != NSNotFound) {
                NSString* value = [html substringWithRange:NSMakeRange(begin, end-begin)];
                return value;
            }
        }
    }
    return nil;
}

- (void) loadGroupById:(NSString*)groupId
{
    self.groupId = groupId;

    // 1. send GET to receiver the page
    _shouldParse = YES;
    if(self.configuration == nil) {
        self.configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    }
    self.session = [NSURLSession sessionWithConfiguration:self.configuration delegate:self delegateQueue:nil];
    
    
    NSURL* url0 = [NSURL URLWithString:[NSString stringWithFormat:@"https://mpei.ru/Education/timetable/Pages/table.aspx?groupid=%@", groupId]];
    NSURLRequest *request0 = [NSURLRequest requestWithURL:url0];
    [self.webView loadRequest:request0];
    return;
    NSURLSessionDataTask *postDataTask0 = [self.session dataTaskWithRequest:request0 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Data=%@", data);
        //NSLog(@"Error=%@", error);
        if(error == nil && data != nil) {
            NSString* html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"Html=%@", html);
            
            NSString* digest  = [self extractValue:@"__REQUESTDIGEST" fromString:html];
            NSString* viewstate  = [self extractValue:@"__VIEWSTATE" fromString:html];
            NSString* viewgenerator = [self extractValue:@"__VIEWSTATEGENERATOR" fromString:html];
            NSString* eventvalidation = [self extractValue:@"__EVENTVALIDATION" fromString:html];
            NSString* eventtarget1 = [self extractPostParameters1:html];
            NSString* eventtarget2 = [self extractPostParameters2:html];
            if(digest != nil && viewstate != nil && viewgenerator != nil && eventvalidation != nil && eventtarget1 != nil)
            {
                NSString* post = [NSString stringWithFormat:@"MSOWebPartPage_PostbackSource=&MSOTlPn_SelectedWpId=&MSOTlPn_View=0&MSOTlPn_ShowSettings=False&MSOGallery_SelectedLibrary=&MSOGallery_FilterString=&MSOTlPn_Button=none&__EVENTTARGET=%@&__EVENTARGUMENT=%@&__REQUESTDIGEST=%@&MSOSPWebPartManager_DisplayModeName=Browse&MSOSPWebPartManager_ExitingDesignMode=false&MSOWebPartPage_Shared=&MSOLayout_LayoutChanges=&MSOLayout_InDesignMode=&_wpSelected=&_wzSelected=&MSOSPWebPartManager_OldDisplayModeName=Browse&MSOSPWebPartManager_StartWebPartEditingName=false&MSOSPWebPartManager_EndWebPartEditing=false&_maintainWorkspaceScrollPosition=0&__VIEWSTATE=%@&__VIEWSTATEGENERATOR=%@&__EVENTVALIDATION=%@&__spDummyText1=&__spDummyText2=&_wpcmWpid=&wpcmVal=", eventtarget1, eventtarget2, digest, viewstate, viewgenerator, eventvalidation];
//                NSString *post = [NSString stringWithFormat: @"groupid=%@&MSOTlPn_SelectedWpId=\"\"&MSOTlPn_View=0&MSOSPWebPartManager_DisplayModeName=Browse&__REQUESTDIGEST=%@&__VIEWSTATE=%@", groupId, digest, viewstate];
                //[self postRequest:groupId post:post];
            }
            [self.webView loadHTMLString:html baseURL:url0];
            
//            NSInteger pos1 = [html rangeOfString:@"name=\"__REQUESTDIGEST\""].location;
//            if(pos1 != NSNotFound) {
//                NSInteger pos2 = [html rangeOfString:@"value=\"" options:0 range:NSMakeRange(pos1, html.length-pos1)].location;
//                if(pos2 != NSNotFound) {
//                    pos2 = pos2+7;
//                    NSInteger pos3 = [html rangeOfString:@"\"" options:0 range:NSMakeRange(pos2, html.length-pos2)].location;
//                    if(pos3 != NSNotFound) {
//                        NSString* digest = [html substringWithRange:NSMakeRange(pos2, pos3-pos2)];
//                    }
//                }
//            }
        }
    }];
    
    [postDataTask0 resume];
}

- (void) loadGroupByName:(NSString*)groupName
{
    self.groupName = groupName;
    
    // 1. send GET to receiver the page
    _shouldParse = YES;
    if(self.configuration == nil) {
        self.configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    }
    self.session = [NSURLSession sessionWithConfiguration:self.configuration delegate:self delegateQueue:nil];
    
    NSString* link = [[NSString stringWithFormat:@"https://mpei.ru/Education/timetable/Pages/default.aspx?group=%@", groupName] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL* url0 = [NSURL URLWithString:link];
    NSURLRequest *request0 = [NSURLRequest requestWithURL:url0];
    [self.webView loadRequest:request0];
    return;
}

- (NSString*) extractValue:(NSString*)name fromString:(NSString*)html
{
    NSString* template = [NSString stringWithFormat:@"name=\"%@\"", name];
    NSInteger pos1 = [html rangeOfString:template].location;
    if(pos1 != NSNotFound) {
        NSInteger pos2 = [html rangeOfString:@"value=\"" options:0 range:NSMakeRange(pos1, html.length-pos1)].location;
        if(pos2 != NSNotFound) {
            pos2 = pos2+7;
            NSInteger pos3 = [html rangeOfString:@"\"" options:0 range:NSMakeRange(pos2, html.length-pos2)].location;
            if(pos3 != NSNotFound) {
                NSString* value = [html substringWithRange:NSMakeRange(pos2, pos3-pos2)];
                return value;
            }
        }
    }
    return nil;
}

- (NSString*) extractPostParameters1:(NSString*)html
{
    NSInteger begin = [html rangeOfString:@":__doPostBack("].location;
    if(begin != NSNotFound) {
        NSInteger begin1 = [html rangeOfString:@"'" options:0 range:NSMakeRange(begin, html.length-begin)].location;
        if(begin1 != NSNotFound) {
            begin1 = begin1 + 1;
            NSInteger end = [html rangeOfString:@"'" options:0 range:NSMakeRange(begin1, html.length-begin1)].location;
            if(end != NSNotFound) {
                NSString* value = [html substringWithRange:NSMakeRange(begin1, end-begin1)];
                return value;
            }
        }
    }
    return nil;
}
- (NSString*) extractPostParameters2:(NSString*)html
{
    NSInteger begin = [html rangeOfString:@":__doPostBack("].location;
    if(begin != NSNotFound) {
        NSInteger begin0 = [html rangeOfString:@"," options:0 range:NSMakeRange(begin, html.length-begin)].location;
        if(begin0 != NSNotFound) {
            NSInteger begin1 = [html rangeOfString:@"'" options:0 range:NSMakeRange(begin0, html.length-begin0)].location;
            if(begin1 != NSNotFound) {
                begin1 = begin1 + 1;
                NSInteger end = [html rangeOfString:@"'" options:0 range:NSMakeRange(begin1, html.length-begin1)].location;
                if(end != NSNotFound) {
                    NSString* value = [html substringWithRange:NSMakeRange(begin1, end-begin1)];
                    return value;
                }
            }
        }
    }
    return nil;
}

- (void) postRequest:(NSString*)groupId post:(NSString*)post
{
//    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"dd MMM yyyy HH:MM:SS Z"];
//    NSString* dateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    NSURL* url = [NSURL URLWithString:@"https://mpei.ru/Education/timetable/Pages/table.aspx"];
    
    //    <input type="hidden" name="MSOTlPn_SelectedWpId" id="MSOTlPn_SelectedWpId" value="" />
    //    <input type="hidden" name="MSOTlPn_View" id="MSOTlPn_View" value="0" />
    //    <input type="hidden" name="MSOTlPn_ShowSettings" id="MSOTlPn_ShowSettings" value="False" />
    //    <input type="hidden" name="MSOGallery_SelectedLibrary" id="MSOGallery_SelectedLibrary" value="" />
    //    <input type="hidden" name="MSOGallery_FilterString" id="MSOGallery_FilterString" value="" />
    //    <input type="hidden" name="MSOTlPn_Button" id="MSOTlPn_Button" value="none" />
    //    <input type="hidden" name="__EVENTTARGET" id="__EVENTTARGET" value="" />
    //    <input type="hidden" name="__EVENTARGUMENT" id="__EVENTARGUMENT" value="" />
    //    <input type="hidden" name="__REQUESTDIGEST" id="__REQUESTDIGEST" value="0x2C0E33C4BFB99991079084F16D20727491298CB4B75FDD379C9D2D6008B0F2886D75C0A7B146292B31B45B7FB091382948CA6788DECD9182CA9357B60DE02CE5,29 Aug 2017 11:01:25 -0000" />
    //    <input type="hidden" name="MSOSPWebPartManager_DisplayModeName" id="MSOSPWebPartManager_DisplayModeName" value="Browse" />
    //    <input type="hidden" name="MSOSPWebPartManager_ExitingDesignMode" id="MSOSPWebPartManager_ExitingDesignMode" value="false" />
    //    <input type="hidden" name="MSOWebPartPage_Shared" id="MSOWebPartPage_Shared" value="" />
    //    <input type="hidden" name="MSOLayout_LayoutChanges" id="MSOLayout_LayoutChanges" value="" />
    //    <input type="hidden" name="MSOLayout_InDesignMode" id="MSOLayout_InDesignMode" value="" />
    //    <input type="hidden" name="_wpSelected" id="_wpSelected" value="" />
    //    <input type="hidden" name="_wzSelected" id="_wzSelected" value="" />
    //    <input type="hidden" name="MSOSPWebPartManager_OldDisplayModeName" id="MSOSPWebPartManager_OldDisplayModeName" value="Browse" />
    //    <input type="hidden" name="MSOSPWebPartManager_StartWebPartEditingName" id="MSOSPWebPartManager_StartWebPartEditingName" value="false" />
    //    <input type="hidden" name="MSOSPWebPartManager_EndWebPartEditing" id="MSOSPWebPartManager_EndWebPartEditing" value="false" />
    //    <input type="hidden" name="_maintainWorkspaceScrollPosition" id="_maintainWorkspaceScrollPosition" value="0" />
    //    <input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwUBMA9kFgJmD2QWAgIBD2QWBAIBD2QWBAIGD2QWAmYPZBYCAgEPFgIeE1ByZXZpb3VzQ29udHJvbE1vZGULKYgBTWljcm9zb2Z0LlNoYXJlUG9pbnQuV2ViQ29udHJvbHMuU1BDb250cm9sTW9kZSwgTWljcm9zb2Z0LlNoYXJlUG9pbnQsIFZlcnNpb249MTQuMC4wLjAsIEN1bHR1cmU9bmV1dHJhbCwgUHVibGljS2V5VG9rZW49NzFlOWJjZTExMWU5NDI5YwFkAhUPZBYCAgcPFgIfAAsrBAFkAgMPZBYMAgMPZBYEBSZnXzIxYzJkZDVlX2ZlM2ZfNDg0MV9hNmZhXzc5OTc1NmE3M2I3Yg9kFgJmD2QWBAICDxAPFgIeB1Zpc2libGVnZGQWAWZkAgMPEGQQFQAVABQrAwAWAGQFJmdfNTQ3ZDU5YzNfZTBhMl80MzhkXzk1NjdfNzA0ZjYxNTA2NDBhD2QWBGYPFgIfAWhkAgEPFgIfAWhkAgcPZBYEZg9kFgQCAQ8WAh8BaBYCZg9kFgQCAg9kFgYCAQ8WAh8BaGQCAw8WCB4TQ2xpZW50T25DbGlja1NjcmlwdAWAAWphdmFTY3JpcHQ6Q29yZUludm9rZSgnVGFrZU9mZmxpbmVUb0NsaWVudFJlYWwnLDEsIDM5LCAnaHR0cDpcdTAwMmZcdTAwMmZtcGVpLnJ1XHUwMDJmRWR1Y2F0aW9uXHUwMDJmdGltZXRhYmxlJywgLTEsIC0xLCAnJywgJycpHhhDbGllbnRPbkNsaWNrTmF2aWdhdGVVcmxkHihDbGllbnRPbkNsaWNrU2NyaXB0Q29udGFpbmluZ1ByZWZpeGVkVXJsZB4MSGlkZGVuU2NyaXB0BSJUYWtlT2ZmbGluZURpc2FibGVkKDEsIDM5LCAtMSwgLTEpZAIFDxYCHwFoZAIDDw8WCh4JQWNjZXNzS2V5BQEvHg9BcnJvd0ltYWdlV2lkdGgCBR4QQXJyb3dJbWFnZUhlaWdodAIDHhFBcnJvd0ltYWdlT2Zmc2V0WGYeEUFycm93SW1hZ2VPZmZzZXRZAusDZGQCAw9kFgICAQ9kFgICAw9kFgICAw9kFgICAQ88KwAFAQAPFgIeD1NpdGVNYXBQcm92aWRlcgURQ3VycmVudE5hdmlnYXRpb25kZAIBD2QWBAIDD2QWAmYPZBYCZg8UKwADZGRkZAIFDw8WBB4EVGV4dAVL0JfQsNC/0YPRgdC6INC/0LDQvdC10LvQuCDQvNC+0L3QuNGC0L7RgNC40L3Qs9CwINGA0LDQt9GA0LDQsdC+0YLRh9C40LrQvtCyHwFoZGQCEw9kFgICAQ9kFgJmD2QWAmYPD2QWBh4FY2xhc3MFIm1zLXNidGFibGUgbXMtc2J0YWJsZS1leCBzNC1zZWFyY2geC2NlbGxwYWRkaW5nBQEwHgtjZWxsc3BhY2luZwUBMGQCGQ9kFgICAQ8QFgIfAWhkFCsBAGQCGw9kFgQCDA9kFgICBQ9kFgICAQ8WAh8ACysEAWQCDg9kFgICAw9kFgICBQ8WAh8ACysEAWQCIQ9kFgICAQ9kFgJmD2QWAgIDD2QWAgIFDw8WBB4GSGVpZ2h0GwAAAAAAAHlAAQAAAB4EXyFTQgKAAWQWAgIBDzwrAAkBAA8WBB4NUGF0aFNlcGFyYXRvcgQIHg1OZXZlckV4cGFuZGVkZ2RkZN/u7zLTgwbygbZfApqkR5TP+CcO" />
    //    </div>
    
    
    
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
        //NSLog(@"Data=%@", data);
        //NSLog(@"Error=%@", error);
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


- (NSString*) loadGroupName
{
    NSString* path = [self groupNameFileName];
    if(![[NSFileManager defaultManager] fileExistsAtPath:path])
        return @"А-04-17";
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    return content;
}

- (BOOL) saveGroupName:(NSString*)groupName
{
    NSString* path = [self groupNameFileName];
    NSError* error=nil;
    BOOL res = [groupName writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
    return res;
}

- (NSString*) groupNameFileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"groupName.plist"];
    return appFile;
}



- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //Check here if still webview is loding the content
    if (webView.isLoading)
        return;
    
    if(_shouldParse) {
        NSString *html = [webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"];
        NSString* js = [self getPostScript:html];
        NSString* res = [self.webView stringByEvaluatingJavaScriptFromString:js];
        NSLog(@"res=%@", res);
    }
    
//        NSInteger begin = [html rangeOfString:@"<article"].location;
//        if(begin != NSNotFound) {
//            NSInteger end = [html rangeOfString:@"</article>"].location;
//            if(end != NSNotFound) {
//                NSString* article = [html substringWithRange:NSMakeRange(begin, (end-begin)+10)];
//                NSURL* url0 = [NSURL URLWithString:[NSString stringWithFormat:@"https://mpei.ru/Education/timetable/Pages/table.aspx?groupid=%@", self.groupId]];
//                [self.webView loadHTMLString:article baseURL:url0];
//            }
//        }
//    }
    _shouldParse = NO;
    
    if(_shouldProcess) {
        [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('myGroup').value = '%@'", self.editGroup.text]];
        _shouldProcess = NO;
    }
    //after code when webview finishes
    //NSLog(@"Webview loding finished\nyourHTMLSourceCodeString=%@", yourHTMLSourceCodeString);
}


@end
