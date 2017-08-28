//
//  GroupDatabase.m
//  MPEITimeTable
//
//  Created by Alex Noyanov on 28.08.17.
//  Copyright © 2017 Popoff Developer Studio. All rights reserved.
//

#import "GroupDatabase.h"

static GroupDatabase* _instance=nil;

@implementation GroupDatabase

+ (GroupDatabase*) getInstance
{
    if(_instance == nil)
        _instance = [[GroupDatabase alloc] init];
    return _instance;
}

+ (void) freeInstance
{
    _instance = nil;
}


- (NSString*) groupNameToGroupId:(NSString*)groupName
{
    groupName = [[groupName stringByReplacingOccurrencesOfString:@"А" withString:@"a"] stringByReplacingOccurrencesOfString:@"а" withString:@"a"];
    groupName = [[groupName lowercaseString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if([groupName isEqualToString:@"a0417"])
        return @"9750000030894";
    
    return @"";
}

@end
