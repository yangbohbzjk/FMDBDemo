//
//  ViewController.h
//  FMDBDemo
//
//  Created by mac on 13-3-20.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate>
{
    
}
@property(nonatomic,retain)NSString * path;

@property (retain, nonatomic) IBOutlet UITextField *nameField;
@property (retain, nonatomic) IBOutlet UITextField *scoreField;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)add:(id)sender;
- (IBAction)del:(id)sender;
- (IBAction)update:(id)sender;
- (IBAction)fetch:(id)sender;

@end
