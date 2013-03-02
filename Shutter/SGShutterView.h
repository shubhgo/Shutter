//
//  SGShutterView.h
//  Shutter
//
//  Created by Shubham Goel on 15/02/13.
//  Copyright (c) 2013 Shubham Goel. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SGShutterViewDelegate <NSObject>
@optional
- (void)reachedStage:(NSString *)stageName atIndex:(NSInteger)stageIndex;
@end


@interface SGShutterView : UIControl

@property (nonatomic, weak) id<SGShutterViewDelegate> delegate;

- (id)  initWithFrame:(CGRect)frame
   teethRotationRange:(NSRange)teethRotationRange
   wheelRotationRange:(NSInteger)wheelRotationRange
           stageArray:(NSArray *)stagesArray;
@end
