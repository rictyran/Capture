//
//  SickSlider.h
//  Capture
//
//  Created by Richard Tyran on 1/21/15.
//  Copyright (c) 2015 Richard Tyran. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SickSliderDelegate;

IB_DESIGNABLE

@interface SickSlider : UIView

@property(nonatomic) IBInspectable float startPosition;
@property(nonatomic) IBInspectable UIColor *sliderColor;
@property(nonatomic) IBInspectable BOOL reverseColor;

@property(nonatomic,assign) id <SickSliderDelegate> delegate;

@end

@protocol SickSliderDelegate <NSObject>

-(void)sliderDidFinishUpdatingWithValues:(float)value;

@end