//
//  ViewController.h
//  照相机demo
//
//  Created by Jason on 11/1/16.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DJCameraViewFinishedDelegate <NSObject>

-(void)DJCameraViewFinishedWithImage:(UIImage *)img;

@end

@interface DJCameraViewController : UIViewController
@property (nonatomic, assign) id delegate;
@end
