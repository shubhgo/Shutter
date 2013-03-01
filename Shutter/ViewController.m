//
//  ViewController.m
//  Shutter
//
//  Created by Shubham Goel on 15/02/13.
//  Copyright (c) 2013 Shubham Goel. All rights reserved.
//

#import "ViewController.h"
#import "SGShutterView.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
@property (strong, nonatomic) SGShutterView *shutter;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    /* Shutter View */
    self.shutter = [[SGShutterView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.shutter.center = CGPointMake(160, 240);
    [self.view addSubview:self.shutter];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
