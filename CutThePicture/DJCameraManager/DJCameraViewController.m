//
//  ViewController.m
//  照相机demo
//
//  Created by Jason on 11/1/16.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "DJCameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIButton+DJBlock.h"
#import "DJCameraManager.h"
#define AppWidth [[UIScreen mainScreen] bounds].size.width
#define AppHeigt [[UIScreen mainScreen] bounds].size.height
#define IDCARD_SCALE  0.63

@interface DJCameraViewController () <DJCameraManagerDelegate>
@property (nonatomic,strong)DJCameraManager *manager;
@end

@implementation DJCameraViewController
/**
 *  在页面结束或出现记得开启／停止摄像
 *
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![self.manager.session isRunning]) {
        [self.manager.session startRunning];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([self.manager.session isRunning]) {
        [self.manager.session stopRunning];
    }
}

- (void)dealloc
{
    NSLog(@"照相机释放了");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLayout];
    [self initPickButton];
    [self initDismissButton];
}

- (void)initLayout
{
    self.view.backgroundColor = [UIColor blackColor];
    UIView *pickView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, AppWidth, AppHeigt)];
    [self.view addSubview:pickView];
    
    
//    UIView * fkView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, AppWidth, AppWidth*IDCARD_SCALE)];
//    fkView.backgroundColor = [UIColor clearColor];
//    fkView.layer.borderWidth = 3;
//    fkView.layer.borderColor = [UIColor whiteColor].CGColor;
//    fkView.center = pickView.center;
//    [self.view addSubview:fkView];
//    
//    
//    UILabel * titLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, fkView.frame.origin.y-35, AppWidth, 25)];
//    titLabel.backgroundColor = [UIColor clearColor];
//    titLabel.text = @"请保持证件在白色方框内拍摄";
//    titLabel.textAlignment = NSTextAlignmentCenter;
//    titLabel.textColor = [UIColor whiteColor];
//    titLabel.font = [UIFont boldSystemFontOfSize:20];
//    [self.view addSubview:titLabel];
    
    DJCameraManager *manager = [[DJCameraManager alloc] init];
    // 传入View的frame 就是摄像的范围
    [manager configureWithParentLayer:pickView];
    manager.delegate = self;
    self.manager = manager;
}

/**
 *  拍照按钮
 */
- (void)initPickButton
{
    static CGFloat buttonW = 80;
    UIButton *button = [self buildButton:CGRectMake(AppWidth/2-buttonW/2, AppWidth+120+(AppHeigt-AppWidth-100-20)/2 - buttonW/2, buttonW, buttonW)
                            normalImgStr:@"shot.png"
                         highlightImgStr:@"shot_h.png"
                          selectedImgStr:@""
                              parentView:self.view];
    WS(self,weak);
    [button addActionBlock:^(id sender) {
        [weak.manager takePhotoWithImageBlock:^(UIImage *originImage, UIImage *scaledImage, UIImage *croppedImage) {
            if (croppedImage) {
                CGFloat width = croppedImage.size.width;
                CGFloat height = croppedImage.size.height;
//                [weak.delegate DJCameraViewFinishedWithImage:[self getPartOfImage:croppedImage rect:CGRectMake(0, (height-(width*IDCARD_SCALE))/2, width, width*IDCARD_SCALE)]];
                [weak.delegate DJCameraViewFinishedWithImage:[self getPartOfImage:croppedImage rect:CGRectMake(0, 0, width, height)]];
                [weak dismissViewControllerAnimated:YES completion:nil];
            }
        }];
    } forControlEvents:UIControlEventTouchUpInside];
}

- (UIImage *)getPartOfImage:(UIImage *)img rect:(CGRect)partRect
{
    CGImageRef imageRef = img.CGImage;
    CGImageRef imagePartRef = CGImageCreateWithImageInRect(imageRef, partRect);
    UIImage *retImg = [UIImage imageWithCGImage:imagePartRef];
    CGImageRelease(imagePartRef);
    return retImg;
}
- (void)initDismissButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(30, AppWidth+120+(AppHeigt-AppWidth-100-20)/2 - 11, 40, 22);
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    WS(self,weak);
    [button addActionBlock:^(id sender) {
        [weak dismissViewControllerAnimated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
/**
 *  点击对焦
 *
 */

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    [self.manager focusInPoint:point];
}

- (UIButton*)buildButton:(CGRect)frame
            normalImgStr:(NSString*)normalImgStr
         highlightImgStr:(NSString*)highlightImgStr
          selectedImgStr:(NSString*)selectedImgStr
              parentView:(UIView*)parentView {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    if (normalImgStr.length > 0) {
        [btn setImage:[UIImage imageNamed:normalImgStr] forState:UIControlStateNormal];
    }
    if (highlightImgStr.length > 0) {
        [btn setImage:[UIImage imageNamed:highlightImgStr] forState:UIControlStateHighlighted];
    }
    if (selectedImgStr.length > 0) {
        [btn setImage:[UIImage imageNamed:selectedImgStr] forState:UIControlStateSelected];
    }
    [parentView addSubview:btn];
    return btn;
}

#pragma -mark DJCameraDelegate
- (void)cameraDidFinishFocus
{
    NSLog(@"对焦结束了");
}
- (void)cameraDidStareFocus
{
    NSLog(@"开始对焦");
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
