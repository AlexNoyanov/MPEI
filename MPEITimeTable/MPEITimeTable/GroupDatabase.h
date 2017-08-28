//
//  GroupDatabase.h
//  MPEITimeTable
//
//  Created by Alex Noyanov on 28.08.17.
//  Copyright © 2017 Popoff Developer Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupDatabase : NSObject

+ (GroupDatabase*) getInstance;
+ (void) freeInstance;

- (NSString*) groupNameToGroupId:(NSString*)groupName;


@end
