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
    // Do any additional setup after loading the view, typically from a nib.
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
    NSString *urlAddress = [@"https://mpei.ru/Education/timetable/Pages/table.aspx?groupid=" stringByAppendingString:groupId];
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
}

@end
