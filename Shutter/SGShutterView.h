//
//  SGShutterView.h
//  Shutter
//
//  Created by Shubham Goel on 15/02/13.
//  Copyright (c) 2013 Shubham Goel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGShutterView : UIControl
- (id)  initWithFrame:(CGRect)frame
   teethRotationRange:(NSRange)teethRotationRange
   wheelRotationRange:(NSInteger)wheelRotationRange
           stageArray:(NSArray *)stagesArray;
@end
