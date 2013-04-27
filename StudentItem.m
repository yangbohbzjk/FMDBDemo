//
//  StudentItem.m
//  FMDBDemo
//
//  Created by mac on 13-3-20.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "StudentItem.h"

@implementation StudentItem
@synthesize name,image,score;
-(void)dealloc
{
    self.name=nil;
    self.image=nil;
    self.score=nil;
    [super dealloc];
}

@end
