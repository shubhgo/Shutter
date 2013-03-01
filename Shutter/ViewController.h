//
//  ViewController.h
//  Shutter
//
//  Created by Shubham Goel on 15/02/13.
//  Copyright (c) 2013 Shubham Goel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGTeethView.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet SGTeethView *teeth;
@property (weak, nonatomic) IBOutlet UIView *someView;
- (IBAction)save:(id)sender;

@end
