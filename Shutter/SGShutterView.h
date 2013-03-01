//
//  SGShutterView.h
//  Shutter
//
//  Created by Shubham Goel on 15/02/13.
//  Copyright (c) 2013 Shubham Goel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGShutterView : UIControl
@property (nonatomic, assign) NSRange teethRotationRange;
@property (nonatomic, assign) NSInteger wheelRotationRange;
@property (nonatomic, strong) NSArray *stagesArray;
- (void)save;
@end
