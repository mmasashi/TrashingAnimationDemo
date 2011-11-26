//
//  ViewController.m
//  TrashingAnimationDemo
//
//  Created by Miyazaki Masashi on 11/11/25.
//  Copyright (c) 2011 mmasashi.jp. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, retain) UIView *targetView;

@end

@implementation ViewController

@synthesize targetView;

- (void)dealloc {
  [self setTargetView:nil];
  [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
}

#pragma mark - animation method


- (void)addTrashAnimationTo:(UIView *)aView
                    toPoint:(CGPoint)point
                   duration:(CGFloat)duration
                   delegate:(id)delegate {

  //// 1st Animation - Transform
  CABasicAnimation* transform_animation = [CABasicAnimation animationWithKeyPath:@"transform"];
  transform_animation.duration = duration;
  transform_animation.autoreverses = NO;
  [transform_animation setDelegate:delegate];
  [transform_animation setTimingFunction:[CAMediaTimingFunction 
                                          functionWithName:kCAMediaTimingFunctionEaseIn]];
  CATransform3D transform = CATransform3DIdentity;

  // from 
  transform_animation.fromValue = [NSValue valueWithCATransform3D:transform];	
    
  // to
  // - rotate
  {
    CATransform3D ntransform = CATransform3DMakeRotation(-0.5, 0, 0, 1.0f);
    transform = ntransform;
  }
  // - scale
  CGFloat scale = 0.1f;
  {
    CATransform3D ntransform = CATransform3DMakeScale(scale, scale, scale);
    transform = CATransform3DConcat(transform, ntransform);
  }
  // - transition
  {
    CGRect rect = aView.frame;
    CATransform3D ntransform =
    CATransform3DMakeTranslation(point.x - rect.size.width/2 + (rect.size.width/2 * 0.1), 
                                 point.y - rect.size.height/2 + (rect.size.height/2 * 0.1),
                                 0.0f);
    transform = CATransform3DConcat(transform, ntransform);
  }
  
  transform_animation.toValue = [NSValue valueWithCATransform3D:transform];
  [aView.layer removeAllAnimations];
  [aView.layer addAnimation:transform_animation forKey:@"trashingAnimation"];

  //// 2nd Animation - Opacity
  {
    CABasicAnimation* opacity_animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacity_animation.duration = duration; 
    opacity_animation.autoreverses = NO;
    [opacity_animation setTimingFunction:[CAMediaTimingFunction 
                                          functionWithName:kCAMediaTimingFunctionEaseIn]];
    opacity_animation.fromValue = [NSNumber numberWithFloat:0.7f];
    opacity_animation.toValue = [NSNumber numberWithFloat:0.0f];	
    [aView.layer addAnimation:opacity_animation forKey:@"trashingAnimation_opaque"];
  }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
  [self.targetView setAlpha:0.0f];
}


#pragma mark - tap handling

- (IBAction)createButtonTapped:(UIButton *)sender {
  [self.targetView removeFromSuperview];
  
  UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(20, 80, 280, 44)];
  [aview setBackgroundColor:[UIColor blueColor]];
  [self setTargetView:aview];
  [self.view addSubview:aview];
  [aview release];
}

- (IBAction)trashButtonTapped:(UIButton *)sender {

  [self addTrashAnimationTo:self.targetView
                    toPoint:CGPointMake(20, 320)
                   duration:5.0f
                   delegate:self];
}

@end
