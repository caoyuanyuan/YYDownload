//
//  ViewController.h
//  YYDownloadTest
//
//  Created by CaoYuanyuan on 2017/1/3.
//  Copyright © 2017年 cyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


- (IBAction)start:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)deleteAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *rateLabel;

@end

