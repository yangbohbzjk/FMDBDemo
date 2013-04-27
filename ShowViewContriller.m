//
//  ShowViewContriller.m
//  FMDBDemo
//
//  Created by mac on 13-3-20.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "ShowViewContriller.h"
#import "StudentItem.h"

@implementation ShowViewContriller
@synthesize dataArray;

-(id)initWithArray:(NSMutableArray *)array
{
    if (self=[super init]) {
        self.dataArray=array;
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    [_tableView release];
   
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellname"];
    if (cell==nil) {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellname"] autorelease];
    }
    StudentItem *student = [dataArray objectAtIndex:indexPath.row];
    
    cell.imageView.image=student.image;
    cell.textLabel.text=[NSString stringWithFormat:@"姓名：%@ 分数：%d",student.name,student.score];
    
    return cell;
}
-(void)dealloc
{
    self.dataArray=nil;
    [super dealloc];
}


@end
