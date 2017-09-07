//
//  BSLoadingView.m
//  BSLoader
//
//  Created by Bisma on 08/08/2017.
//  Copyright © 2017 Bisma. All rights reserved.
//

#import "BSLoadingView.h"
#define k_Animation_Duration 1.0
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@implementation BSLoadingView

-(id)init{
    
    if (self=[super init]) {
        
        self.frame=CGRectMake(20, 20, 20, 20);
        [self initializeLoadingView:15];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        
        self.frame=frame;
        [self initializeLoadingView:15];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame circleSize:(float)circleSize{
    
    if (self=[super initWithFrame:frame]) {
        
        self.frame=frame;
        [self initializeLoadingView:circleSize];
    }
    return self;
}
-(void)initializeLoadingView:(float)circleSize{
    
    _circleLayerOne = [CAShapeLayer layer];
    [_circleLayerOne setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, circleSize, circleSize)] CGPath]];
    _circleLayerOne.fillColor=[UIColor clearColor].CGColor;
    [[self layer] addSublayer:_circleLayerOne];
    
    _circleLayerTwo = [CAShapeLayer layer];
    [_circleLayerTwo setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(circleSize+5, 0, circleSize, circleSize)] CGPath]];
    _circleLayerTwo.fillColor=[UIColor clearColor].CGColor;
    [[self layer] addSublayer:_circleLayerTwo];
    
    _circleLayerThree = [CAShapeLayer layer];
    [_circleLayerThree setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake((circleSize+5)*2, 0, circleSize, circleSize)] CGPath]];
    _circleLayerThree.fillColor=[UIColor clearColor].CGColor;
    [[self layer] addSublayer:_circleLayerThree];
    
    _circleLayerFour = [CAShapeLayer layer];
    [_circleLayerFour setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake((circleSize+5)*3, 0, circleSize, circleSize)] CGPath]];
    _circleLayerFour.fillColor=[UIColor clearColor].CGColor;
    [[self layer] addSublayer:_circleLayerFour];
    
    _circleLayerFive = [CAShapeLayer layer];
    [_circleLayerFive setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake((circleSize+5)*4, 0, circleSize, circleSize)] CGPath]];
    _circleLayerFive.fillColor=[UIColor clearColor].CGColor;
    [[self layer] addSublayer:_circleLayerFive];

    
    [self startAnimations];
    [NSTimer scheduledTimerWithTimeInterval:k_Animation_Duration repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self startAnimations];
    }];
    }
-(CAKeyframeAnimation*)createAnimation{

    CAKeyframeAnimation *colorsAnimation = [CAKeyframeAnimation animationWithKeyPath:@"fillColor"];
    
    colorsAnimation.values = [NSArray arrayWithObjects: (id)UIColorFromRGB(0xe45f56).CGColor,
    (id)UIColorFromRGB(0xa3d39c).CGColor,
     (id)UIColorFromRGB(0x7accc8).CGColor,
      (id)UIColorFromRGB(0x4aaaa5).CGColor,
      (id)UIColorFromRGB(0x35404f).CGColor, nil];
    
    colorsAnimation.keyTimes = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.20], [NSNumber numberWithFloat:0.4], [NSNumber numberWithFloat:0.6],[NSNumber numberWithFloat:0.8],[NSNumber numberWithFloat:1.0], nil];
    colorsAnimation.calculationMode = kCAAnimationPaced;
    colorsAnimation.removedOnCompletion = NO;
    colorsAnimation.fillMode = kCAFillModeForwards;
    colorsAnimation.duration = k_Animation_Duration;

    
    return colorsAnimation;
}
-(void)startAnimations{
    
    [_circleLayerOne removeAllAnimations];
    [_circleLayerTwo removeAllAnimations];
    [_circleLayerThree removeAllAnimations];
    [_circleLayerFour removeAllAnimations];
    [_circleLayerFive removeAllAnimations];
    
    CAKeyframeAnimation *oneAnimation=[self createAnimation];
    [_circleLayerOne addAnimation:oneAnimation forKey:@"fillColor"];
    
    CAKeyframeAnimation *twoAnimation=[self createAnimation];
    twoAnimation.beginTime=CACurrentMediaTime() +k_Animation_Duration*0.15;
    [_circleLayerTwo addAnimation:twoAnimation forKey:@"fillColor"];
    
    CAKeyframeAnimation *threeAnimation=[self createAnimation];
    threeAnimation.beginTime=CACurrentMediaTime() +(k_Animation_Duration*0.30);
    [_circleLayerThree addAnimation:threeAnimation forKey:@"fillColor"];
    
    CAKeyframeAnimation *fourAnimation=[self createAnimation];
    fourAnimation.beginTime=CACurrentMediaTime() +(k_Animation_Duration*0.45);
    [_circleLayerFour addAnimation:fourAnimation forKey:@"fillColor"];
    
    CAKeyframeAnimation *fiveAnimation=[self createAnimation];
    fiveAnimation.beginTime=CACurrentMediaTime() +(k_Animation_Duration*0.60);
    [_circleLayerFive addAnimation:fiveAnimation forKey:@"fillColor"];

}
@end
