//
//  ShowViewContriller.h
//  FMDBDemo
//
//  Created by mac on 13-3-20.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowViewContriller : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
}
@property (nonatomic,retain) NSMutableArray * dataArray;

-(id)initWithArray:(NSMutableArray*)array;

@end
