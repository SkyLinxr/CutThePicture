//
//  ViewController.m
//  CutThePicture
//
//  Created by Skylin on 2017/9/1.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "ViewController.h"
#import "DJCameraViewController.h"
#import <Photos/Photos.h>

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,DJCameraViewFinishedDelegate>
{
    NSArray * cutNum;
    int cutNumX;
    int cutNumY;
    UIView * SPView;
    UIView * CZView;
    UIImage * OriginalImage;
    int saveSuccessNum;
}
@property(nonatomic,strong)UIView * CutNumView;
@property(nonatomic,strong)UIView * ActionView;
@property(nonatomic,strong)UIView * CutDoneShowView;
@property(nonatomic,strong)NSMutableArray * cutImgArr;
@property(nonatomic,strong)UIImageView * OriginalImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    saveSuccessNum = 0;
    [self makeUI];
}
-(void)makeUI
{
    [self.view addSubview:self.CutNumView];
    [self.view addSubview:self.OriginalImageView];
    [self.view addSubview:self.ActionView];
}
#pragma mark - UI
-(UIView *)CutNumView
{
    if (!_CutNumView) {
        
        cutNum = @[@"2",@"3",@"4",@"5"];
        cutNumX = [cutNum[0] intValue];
        cutNumY = [cutNum[0] intValue];
        NSArray * labelTitleArr = @[@"横向",@"纵向"];
        CGFloat labelWidth = 60;
        CGFloat H_size = 30;
        CGFloat W_size = (IPHONE_WIDTH-labelWidth)/cutNum.count;
        
        _CutNumView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, IPHONE_WIDTH, H_size*2)];
        _CutNumView.backgroundColor = [UIColor blackColor];
        

        SPView = [[UIView alloc]initWithFrame:CGRectMake(labelWidth, 0, IPHONE_WIDTH-labelWidth, H_size)];
        [_CutNumView addSubview:SPView];
        
        CZView = [[UIView alloc]initWithFrame:CGRectMake(labelWidth, H_size, IPHONE_WIDTH-labelWidth, H_size)];
        [_CutNumView addSubview:CZView];
        

        for (int i=0; i<labelTitleArr.count; i++) {
            UILabel * label = [GJ_Control createLabelWithFrame:CGRectMake(0, i*H_size, labelWidth, H_size) Font:15 Text:labelTitleArr[i] setColor:[UIColor whiteColor] numberOfLines:1 textAlignment:NSTextAlignmentCenter];
            [_CutNumView addSubview:label];
        }
        
        CGFloat JG = ((IPHONE_WIDTH-labelWidth)-(cutNum.count*W_size))/cutNum.count-1;
        for (int i=0; i<cutNum.count; i++) {
            UIButton * btn = [GJ_Control createButtonWithFrame:CGRectMake(i*(W_size+JG), 0, W_size, H_size) SetImage:nil SetBackgroundImage:nil Target:self Action:@selector(X_SelectCutNum:) Title:cutNum[i] setBackgroundColorWithSys:nil setTitleColor:nil setTag:i];
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:25];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
            [SPView addSubview:btn];
            
            if (i==0) {btn.selected = YES;}
        }
        
        for (int i=0; i<cutNum.count; i++) {
            UIButton * btn = [GJ_Control createButtonWithFrame:CGRectMake(i*(W_size+JG), 0, W_size, H_size) SetImage:nil SetBackgroundImage:nil Target:self Action:@selector(Y_SelectCutNum:) Title:cutNum[i] setBackgroundColorWithSys:nil setTitleColor:nil setTag:i];
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:25];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
            [CZView addSubview:btn];
            
            if (i==0) {btn.selected = YES;}
        }
    }
    
    return _CutNumView;
}

-(UIImageView *)OriginalImageView
{
    if (!_OriginalImageView) {
    
        _OriginalImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, View_StartFrom_Y(self.CutNumView), IPHONE_WIDTH, IPHONE_HEIGHT-100-View_StartFrom_Y(self.CutNumView))];
        _OriginalImageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
    }
    
    return _OriginalImageView;
}
-(UIView *)CutDoneShowView
{
    if (!_CutDoneShowView) {
        _CutDoneShowView = [[UIView alloc]initWithFrame:self.OriginalImageView.frame];
        _CutDoneShowView.backgroundColor = RandomColor;
        [self.view addSubview:_CutDoneShowView];
    }
    return _CutDoneShowView;
}
-(UIView *)ActionView
{
    if (!_ActionView) {
        _ActionView = [[UIView alloc]initWithFrame:CGRectMake(0, IPHONE_HEIGHT-100, IPHONE_WIDTH, 100)];
        
        NSArray * btnTitleArr = @[@"选择",@"切割",@"保存"];
        CGFloat size = 80;
        CGFloat JG = (IPHONE_WIDTH-(size*btnTitleArr.count))/(btnTitleArr.count+1);
        for (int i=0; i<btnTitleArr.count; i++) {
            UIButton * btn = [GJ_Control createButtonWithFrame:CGRectMake(JG+i*(size+JG), (View_Height(_ActionView)-size)/2, size, size) SetImage:nil SetBackgroundImage:nil Target:self Action:@selector(ActionBtnClick:) Title:btnTitleArr[i] setBackgroundColorWithSys:RandomColor setTitleColor:[UIColor whiteColor] setTag:i];
            btn.layer.cornerRadius = size/2;
            btn.layer.masksToBounds = YES;
            [_ActionView addSubview:btn];
        }
    }
    return _ActionView;
}

#pragma mark - 按钮点击事件
-(void)X_SelectCutNum:(UIButton *)btn
{
    int tag = (int)btn.tag;
    cutNumX = [cutNum[tag] intValue];
    for (UIButton * b in SPView.subviews) {
        if ([b isKindOfClass:[UIButton class]] && b.tag==tag) {
            b.selected = YES;
        }else{
            b.selected = NO;
        }
    }
    
}
-(void)Y_SelectCutNum:(UIButton *)btn
{
    int tag = (int)btn.tag;
    cutNumY = [cutNum[tag] intValue];
    for (UIButton * b in CZView.subviews) {
        if ([b isKindOfClass:[UIButton class]] && b.tag==tag) {
            b.selected = YES;
        }else{
            b.selected = NO;
        }
    }
}

-(void)ActionBtnClick:(UIButton *)btn
{
    int tag = (int)btn.tag;
    switch (tag) {
        case 0://选择
        {
            [self ChooseImage];
        }
            break;
        case 1://切割
        {
            if (self.OriginalImageView.image==nil) {
                SKToast(@"请先选择图片");
            }else{
                [self CutPictureAction];
            }
        }
            break;
        case 2://保存
        {
            if (self.OriginalImageView.image==nil) {
                SKToast(@"请先选择图片");
            }else if(!_CutDoneShowView){
                SKToast(@"还未切割");
            }else{
                [self SaveCutImgToPricute];
            }
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - 选择照片及相关代理
-(void)ChooseImage
{
    UIActionSheet* sheet =[[UIActionSheet alloc] initWithTitle:@"选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册",nil];
    [sheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 2) {
        return;
    }
    //选择相机相册
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
    if (!buttonIndex) {
        //判断相机是否可以启动
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
            DJCameraViewController *VC = [DJCameraViewController new];
            VC.delegate                = self;
            [self presentViewController:VC animated:YES completion:nil];
        }
    }
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}
-(void)DJCameraViewFinishedWithImage:(UIImage *)img
{
    OriginalImage = img;
    self.OriginalImageView.image = img;
    [self.view sendSubviewToBack:self.CutDoneShowView];
    [self.view bringSubviewToFront:self.OriginalImageView];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * _image   = [info objectForKey:UIImagePickerControllerOriginalImage];
    OriginalImage = _image;
    self.OriginalImageView.image = _image;
    [self.view sendSubviewToBack:self.CutDoneShowView];
    [self.view bringSubviewToFront:self.OriginalImageView];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 切割图片
-(void)CutPictureAction
{
    //获取原图的宽高
    CGFloat width =  OriginalImage.size.width;
    CGFloat height =  OriginalImage.size.height;
    
    //计算切割后小图的宽高
    CGFloat cutWidth = width/cutNumX;
    CGFloat cutHeight = height/cutNumY;
    
    //展示img宽高
    CGFloat imgWidth = View_Width(self.OriginalImageView)/cutNumX;
    CGFloat imgHeight = View_Height(self.OriginalImageView)/cutNumY;
    
    int num = cutNumX*cutNumY;
    self.cutImgArr = [NSMutableArray array];
    for (int i=0; i<num; i++) {
        CGRect rect = CGRectMake(i%cutNumX*cutWidth, i/cutNumX*cutHeight, cutWidth, cutHeight);
        [self.cutImgArr addObject:[self clipImageInRect:rect]];
    }
    
    if (_CutDoneShowView) {
        [_CutDoneShowView removeFromSuperview];
        _CutDoneShowView = nil;
    }
    
    for (int i=0; i<self.cutImgArr.count; i++) {
        UIImage * img = self.cutImgArr[i];
        CGRect rect = CGRectMake(i%cutNumX*imgWidth, i/cutNumX*imgHeight, imgWidth, imgHeight);
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:rect];
        imgView.image = img;
        imgView.layer.borderWidth = 1.5;
        imgView.layer.borderColor = [UIColor whiteColor].CGColor;
        [self.CutDoneShowView addSubview:imgView];
    }
    
    [self.view bringSubviewToFront:self.CutDoneShowView];
    [self.view sendSubviewToBack:self.OriginalImageView];
    [self.view bringSubviewToFront:self.ActionView];
}

- (UIImage *)clipImageInRect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect(OriginalImage.CGImage, rect);
    UIImage *thumbScale = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return thumbScale;
}

//截取自定义坐标view
- (UIImage *)screenshotWithRect:(CGRect)rect;
{
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context == NULL)
    {
        return nil;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, -rect.origin.x, -rect.origin.y);
    
    //[self layoutIfNeeded];
    
    if( [self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
    {
        [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:NO];
    }
    else
    {
        [self.view.layer renderInContext:context];
    }
    
    CGContextRestoreGState(context);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - 保存到相册
-(void)SaveCutImgToPricute
{
    [SVProgressHUD show];
    for (int i=0; i<self.cutImgArr.count; i++) {
        [self saveImageToPhotos:self.cutImgArr[i]];
    }
//     [self saveImageToPhotos:[self screenshotWithRect:self.CutDoneShowView.frame]];
}
//实现该方法
- (void)saveImageToPhotos:(UIImage*)savedImage
{
    @synchronized(self){
        
        WS(self, weakSelf);
        
        //修改系统相册用PHPhotoLibrary单粒,调用performChanges,否则苹果会报错,并提醒你使用
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            
            // 调用判断是否已有该名称相册
            PHAssetCollection *assetCollection = [self fetchAssetColletion:@"图片剪切"];
            
            //创建一个操作图库的对象
            PHAssetCollectionChangeRequest *assetCollectionChangeRequest;
            
            if (assetCollection) {
                // 已有相册
                assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
            } else {
                // 1.创建自定义相册
                assetCollectionChangeRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:@"图片剪切"];
            }
            
            // 2.保存你需要保存的图片到系统相册(这里保存的是_imageView上的图片)
            PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:savedImage];
            
            // 3.把创建好图片添加到自己相册
            //这里使用了占位图片,为什么使用占位图片呢
            //这个block是异步执行的,使用占位图片先为图片分配一个内存,等到有图片的时候,再对内存进行赋值
            PHObjectPlaceholder *placeholder = [assetChangeRequest placeholderForCreatedAsset];
            
            [assetCollectionChangeRequest addAssets:@[placeholder]];
            
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            //弹出一个界面提醒用户是否保存成功
            if (!error) {
                saveSuccessNum++;
            }
            NSString * msg = [NSString stringWithFormat:@"已保存%d张",saveSuccessNum];
            NSLog(@"---------> %@",msg);
            if (saveSuccessNum==cutNumX*cutNumY) {
                [weakSelf cutDone];
            }
        }];
    }
}
-(void)cutDone
{
    dispatch_async(dispatch_get_main_queue(), ^{
        saveSuccessNum = 0;
        [SVProgressHUD showSuccessWithStatus:@"保存完成"];
    });
}
#pragma mark - 该方法获取在图库中是否已经创建该App的相册
//该方法的作用,获取系统中所有的相册,进行遍历,若是已有相册,返回该相册,若是没有返回nil,参数为需要创建  的相册名称
- (PHAssetCollection *)fetchAssetColletion:(NSString *)albumTitle
{
    
    // 获取所有的相册
    
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum
                                                                     subtype:PHAssetCollectionSubtypeAlbumRegular
                                                                     options:nil];
    
    //遍历相册数组,是否已创建该相册
    for (PHAssetCollection *assetCollection in result) {
        if ([assetCollection.localizedTitle isEqualToString:albumTitle]) {
            return assetCollection;
        }
    }
    
    return nil;
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
