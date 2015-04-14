//
//  SickSlider.m
//  Capture
//
//  Created by Richard Tyran on 1/21/15.
//  Copyright (c) 2015 Richard Tyran. All rights reserved.
//

#import "SickSlider.h"

@implementation SickSlider

{
    float sliderPosition;
}

-(void)setStartPosition:(float)startPosition {
    
    sliderPosition = startPosition * self.frame.size.width;
    
    [self setNeedsDisplay];
    
    _startPosition = startPosition;
}

-(UIColor *)sliderColor {
    
    if (_sliderColor ==nil) {
        _sliderColor = [UIColor whiteColor];
        
    }
    
    return _sliderColor;
}

-(void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self.sliderColor set];
    
    CGContextSetLineWidth(context, 3);
    
    CGRect insetRect = CGRectInset(rect, 1, 1);
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:insetRect cornerRadius:rect.size.height /2];
    
    CGContextAddPath(context, path.CGPath);
    
    if (self.reverseColor) {
        
        CGContextFillPath(context);
        
    } else {
        
        CGContextStrokePath(context);
        
    }
    
    
    CGRect circleRect = CGRectInset(insetRect, 4, 4);
    circleRect.size.width = circleRect.size.height;
    
    float minX = circleRect.origin.x;
    float maxX = rect.size.width - minX - circleRect.size.width;
    
    sliderPosition -= circleRect.size.width / 2;
    
    if (sliderPosition > maxX) sliderPosition = maxX;
    if (sliderPosition < minX) sliderPosition = minX;
    
    circleRect.origin.x = sliderPosition;
    
    float value = (sliderPosition - minX) / (maxX - minX);
    
    [self.delegate sliderDidFinishUpdatingWithValues:value];
    
    if (self.reverseColor) {
        
        //        CGContextSetBlendMode(context, kCGBlendModeClear);
        
        [self.backgroundColor set];
    }
    
    
    CGContextFillEllipseInRect(context,circleRect);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self updateSliderWithTouches:touches];
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self updateSliderWithTouches:touches];
    
}

-(void)updateSliderWithTouches:(NSSet *)touches {
    
    UITouch * touch = touches.allObjects.firstObject;
    
    CGPoint location = [touch locationInView:self];
    
    sliderPosition = location.x;
    
    [self setNeedsDisplay];
    
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
