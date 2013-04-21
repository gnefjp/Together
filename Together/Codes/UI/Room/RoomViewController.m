//
//  RoomViewController.m
//  Together
//
//  Created by Gnef_jp on 13-4-22.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "RoomViewController.h"

@implementation RoomViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
}


- (IBAction)closeBtnPressed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
