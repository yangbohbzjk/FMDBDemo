//
//  ViewController.m
//  FMDBDemo
//
//  Created by mac on 13-3-20.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "FMDatabase.h"
#import "ShowViewContriller.h"
#import "StudentItem.h"

@implementation ViewController
@synthesize nameField;
@synthesize scoreField;
@synthesize imageView,path;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.path=NSHomeDirectory();
    self.path=[self.path stringByAppendingPathComponent:@"Documents/Data.db"];
    
    
    imageView.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseImage)];
    [imageView addGestureRecognizer:tap];
    [tap release];
}
-(void)chooseImage
{
    UIImagePickerController * ipc = [[UIImagePickerController alloc] init];
    ipc.delegate=self;
    [self presentModalViewController:ipc animated:YES];
    [ipc release];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    imageView.image=image;
    [picker dismissModalViewControllerAnimated:YES];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [self setNameField:nil];
    [self setScoreField:nil];
    [self setImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [nameField release];
    [scoreField release];
    [imageView release];
    [super dealloc];
}
- (IBAction)add:(id)sender {
    FMDatabase * db = [FMDatabase databaseWithPath:path];
    BOOL res = [db open];
    if (res==NO) {
        NSLog(@"open error");
        return;
    }
    
    res=[db executeUpdate:@"create table if not exists Students(name,score,image)"];
    if (res==NO) {
        NSLog(@"create error");
        [db close];
        return;
    }
    //插入数据 nsNumber NSString NSData
    NSString * name = nameField.text;
    NSNumber * num = [NSNumber numberWithInt:[scoreField.text intValue]];
    NSData * data = UIImagePNGRepresentation(imageView.image);
    //sql注入
    res = [db executeUpdate:@"insert into Students values(?,?,?)",name,num,data];
    if (res==NO) {
        NSLog(@"insert error");
    }
    [db close];
    UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"添加成功" message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
    [av show];
    [av release];
}
//删
- (IBAction)del:(id)sender {
    FMDatabase * db = [FMDatabase databaseWithPath:path];
    BOOL res=[db open];
    if (res==NO) {
        NSLog(@"open error");
        return;
    }
    res = [db executeUpdate:@"delete from Students where name=?",nameField.text];
    if (res==NO) {
        NSLog(@"delete error");
    }
    [db close];
    UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"删除成功" message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
    [av show];
    [av release];
}
- (IBAction)update:(id)sender {
    FMDatabase * db = [FMDatabase databaseWithPath:path];
    BOOL res = [db open];
    if (!res) {
        NSLog(@"open error");
        return;
    }
    NSData * data = UIImagePNGRepresentation(imageView.image);
    res = [db executeUpdate:@"update Students set score=? where name=?",scoreField.text,nameField.text];
    res = [db executeUpdate:@"update Students set image=? where name=?",data,nameField.text];
    if (res==NO) {
        NSLog(@"update error");
        [db close];
        return;
    }
    [db close];
    UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"修改成功" message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
    [av show];
    [av release];
}

- (IBAction)fetch:(id)sender {
    NSLog(@"查");
    FMDatabase * db = [FMDatabase databaseWithPath:path];
    BOOL res = [db open];
    if (res==NO) {
        NSLog(@"open error");
        return;
    }
    FMResultSet * set = [db executeQuery:@"select * from Students"];
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:0];
    while ([set next]) {
        NSString * name = [set stringForColumn:@"name"];
        int score = [set intForColumn:@"score"];
        NSData * data = [set dataForColumn:@"image"];
        UIImage * image = [UIImage imageWithData:data];
        
        StudentItem * item = [[StudentItem alloc] init];
        item.name=name;
        item.score=score;
        item.image=image;
        [array addObject:item];
        [item release];
    }
    [db close];
    
    ShowViewContriller * svc = [[ShowViewContriller alloc] initWithArray:array];
    NSLog(@"WTF");
    [self.navigationController pushViewController:svc animated:YES];
    [svc release];
}
-(void)abc
{
    
}

//键盘失去第一响应
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [nameField resignFirstResponder];
    [scoreField resignFirstResponder];
}
@end
