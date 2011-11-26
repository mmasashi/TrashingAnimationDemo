//
//  ViewController.h
//  TrashingAnimationDemo
//
//  Created by Miyazaki Masashi on 11/11/25.
//  Copyright (c) 2011 mmasashi.jp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController {
 @private
  UIView *targetView;
}

- (IBAction)createButtonTapped:(UIButton *)sender;
- (IBAction)trashButtonTapped:(UIButton *)sender;

@end
