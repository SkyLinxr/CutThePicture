//
//  GJ_Control.h
//
//  Created by ShiLei on 14-3-6.
//  Copyright (c) 2014年 shilei. All rights reserved.
//
//使用此类，在工程pch文件里面加入该头文件，即可在工程内任意地方进行创建
//此类设计模式为最简单的工厂模式
//UI，GJ_Control
//网络  httpdownload
//数据库  SQL


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//用于判断金额和电话号码的输入限制
#define myDotNumbers     @"0123456789.\n"
#define myNumbers        @"0123456789\n"

#define SLAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define SKToast(Msg)  if (STRING_IS_NOT_EMPTY(Msg)) {[[UIViewController currentViewController].view makeToast:Msg];};
#define WS(self,weakSelf)  __weak __typeof(&*self)weakSelf = self

#pragma mark - RGB颜色
#define COLORWITHRGBA(R,G,B,A) [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)]
#define WKColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define MakeColorHex(hex)  [UIColor colorWithRed:((hex & 0xFF0000) >> 16) / 255.f green:((hex & 0xFF00) >> 8) / 255.f blue:(hex & 0xFF) / 255.f alpha:1]

#pragma mark - 设备系统识别
#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define iOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]

#pragma mark - 设备型号识别
#define Device_iPhone_3_5 (IPHONE_WIDTH==320&&IPHONE_HEIGHT==480)
#define Device_iPhone_4_0 (IPHONE_WIDTH==320&&IPHONE_HEIGHT==568)
#define Device_iPhone_4_7 (IPHONE_WIDTH==375&&IPHONE_HEIGHT==667)
#define Device_iPhone_5_5 (IPHONE_WIDTH==414&&IPHONE_HEIGHT==736)

#pragma mark - 硬件
#define IPHONE_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define IPHONE_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define HAVE_TABBAR_HEIGHT  IPHONE_HEIGHT-Height_NavigationBar-Height_TabBar
#define NOHAVE_TABBAR_HEIGHT  IPHONE_HEIGHT-Height_NavigationBar

#pragma mark - 控件Size
#define View_Width(view) (view.frame.size.width)
#define View_Height(view) (view.frame.size.height)
#define View_X(view) (view.frame.origin.x)
#define View_Y(view) (view.frame.origin.y)
#define View_StartFrom_X(view) (View_Width(view)+View_X(view))
#define View_StartFrom_Y(view) (View_Height(view)+View_Y(view))
#define View_SetSize(View,width,height) View.frame = CGRectMake(View.frame.origin.x, View.frame.origin.y, width, height)
#define View_SetOrigin(View,X,Y) View.frame = CGRectMake(X, Y, View.frame.size.width, View.frame.size.height)

//键盘ToolBar高度
#define Height_keyBoardTool 40

#pragma mark - 系统控件
#define Height_TabBar 49
#define Height_NavigationBar [GJ_Control NavightionHeight]

#pragma mark- 随机
#define RandomColor  [UIColor colorWithHue: (arc4random()% 256/256.0) saturation:(arc4random()%128/256.0)+0.5 brightness:(arc4random()%128/256.0)+ 0.5 alpha:1]
#define RandomNumber [NSString stringWithFormat:@"%.5d",arc4random() % 10000]
#define RandomNumBer(x) (arc4random() % x)

#pragma mark - UserDefaults的存储和读取
#define SaveUserDefaults(key,value) [[NSUserDefaults standardUserDefaults]setValue:value forKey:key];[[NSUserDefaults standardUserDefaults] synchronize]
#define GetUserDefaults(key)[[NSUserDefaults standardUserDefaults]objectForKey:key]
#define RemoveUserDefaults(key)[[NSUserDefaults standardUserDefaults]removeObjectForKey:key]

#pragma mark - NSNotificationCenter通知中心
#define Notification_ADD(observer,aSelector,aName,anObject) [[NSNotificationCenter defaultCenter] addObserver:observer selector:@selector(aSelector) name:aName object:anObject]
#define Notification_POST(aName,anObject) [[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject]
#define Notification_POST_Info(aName,anObject,aUserInfo) [[NSNotificationCenter defaultCenter]postNotificationName:aName object:anObject userInfo:aUserInfo]
#define Notification_REMOVE(observer,aName,anObject) [[NSNotificationCenter defaultCenter]removeObserver:observer name:aName object:anObject]
#define Notification_REMOVEAll(vc) [[NSNotificationCenter defaultCenter]removeObserver:vc]

#pragma mark - 判断数据是否为空
#define STRING_IS_NOT_EMPTY(string) (string !=nil && [string isKindOfClass:[NSString class]] && ![string isEqualToString:@""])
#define ARRAY_IS_NOT_EMPTY(array) (array && [array isKindOfClass:[NSArray class]] && [array count])
#define DICT_IS_NOT_EMPTY(responseObject) [responseObject isKindOfClass:[NSDictionary class]]&&[responseObject count]
#define DICT_HAVE_KEY(dict,key) [[dict allKeys] containsObject:key]

#define VC_PUSH(VC)   VC *viewVC = [[VC alloc]init];\
[self.navigationController pushViewController:viewVC animated:YES];

#pragma mark - Cell的两种实例化方法
#define CELL_NAME(UITableViewCell,identStr,color)     static NSString *identifier = identStr;\
UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];\
if (cell == NULL){\
cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];\
cell.selectionStyle = UITableViewCellSelectionStyleNone;\
cell.backgroundColor = color;\
}\

#define CELL_XIB(UITableViewCell,cellName,color)     static NSString *identifier = cellName;\
UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];\
if (cell == NULL){\
cell = [[[NSBundle mainBundle]loadNibNamed:cellName owner:self options:nil]lastObject];\
cell.selectionStyle = UITableViewCellSelectionStyleNone;\
cell.backgroundColor = color;\
}\

#pragma mark - 自定义分割线
//底部横线
#define createFooterLineView(x,view,lineName,height,color) UIView * lineName = [[UIView alloc]initWithFrame:CGRectMake(x, View_Height(view)-height, IPHONE_WIDTH-(2*x), height)];\
lineName.backgroundColor = color;\
[view addSubview:lineName];

//头部横线
#define createHeaderLineView(x,view,lineName,height) UIView * lineName = [[UIView alloc]initWithFrame:CGRectMake(x, 0, IPHONE_WIDTH-(2*x), height)];\
lineName.backgroundColor = [UIColor groupTableViewBackgroundColor];\
[view addSubview:lineName];

//自定义位置横线
#define createCustomLineView(Rect,color,superView,lineName) UIView * lineName = [[UIView alloc]initWithFrame:Rect];\
lineName.backgroundColor = color;\
[superView addSubview:lineName];\
lineName.alpha = 0.3;\

//新版分割线
#define createDivisionLine_H(x,y,superView,line1,line2) \
UIView * line1 = [[UIView alloc]initWithFrame:CGRectMake(x, y, IPHONE_WIDTH-(2*x), 1.5)];\
line1.backgroundColor = [GJ_Control colorWithHexString:@"000000"];\
[superView addSubview:line1];\
UIView * line2 = [[UIView alloc]initWithFrame:CGRectMake(x, y+1.5, IPHONE_WIDTH-(2*x), 0.5)];\
line2.backgroundColor = [GJ_Control colorWithHexString:@"404040"];\
[superView addSubview:line2];\

#define createDivisionLine_S(x,y,superView,line1,line2) \
UIView * line1 = [[UIView alloc]initWithFrame:CGRectMake(x, y, 1.5, View_Height(superView)-(2*y))];\
line1.backgroundColor = [GJ_Control colorWithHexString:@"000000"];\
[superView addSubview:line1];\
UIView * line2 = [[UIView alloc]initWithFrame:CGRectMake(x+1.5, y, 0.5, View_Height(superView)-(2*y))];\
line2.backgroundColor = [GJ_Control colorWithHexString:@"404040"];\
[superView addSubview:line2];\


//发送请求结果通知
#define SK_RESDict(tag,type,data,status) NSMutableDictionary * resDict = [NSMutableDictionary dictionary];\
[resDict setObject:@(tag) forKey:@"type"];\
[resDict setObject:@(type) forKey:@"tag"];\
[resDict setObject:data forKey:@"data"];\
Notification_POST(status, resDict);



#pragma mark - 角度弧度计算
//角度->【弧度】
#define _Radian_By_Angle(Angle) Angle*M_PI/180
//数值->【弧度】
#define _Radian_By_Value(Value) _Radian_By_Angle(_Angle_By_Value(Value))
//弧度->【角度】
#define _Angle_By_Radian(Radian) Radian/M_PI*180
//数值->【角度】
#define _Angle_By_Value(Value)  Value/100*360
//数值——>【Sin(正弦)】
#define _Sin_By_Value(Value)  sin(_Radian_By_Angle(Value))
//数值——>【Cos(余弦)】
#define _Cos_By_Value(Value)  cos(_Radian_By_Angle(_Angle_By_Value(Value)))


@interface GJ_Control : NSObject
//首尾去除空格
+ (NSString *)removeSpaceAtFromAndEnd:(NSString *)sss;

#pragma mark --创建Label
+(UILabel*)createLabelWithFrame:(CGRect)frame Font:(int)font Text:(NSString*)text setColor:(UIColor *)textColor numberOfLines:(int)numberOfLine textAlignment:(NSTextAlignment)textAlignment;
//工厂模式
+(UILabel*)createLabelWithFrame:(CGRect)frame Font:(UIFont*)font numberOfLines:(int)numberOfLine Text:(NSString*)text setColor:(UIColor*)textColor  textAlignment:(NSTextAlignment)textAlignment backgroundColor:(UIColor*)bgColor adjustsFontSizeToFitWidth:(BOOL)yesOrNo;


#pragma mark --创建View
+(UIView*)viewWithFrame:(CGRect)frame setBackgroundColor:(UIColor *)bgColor alpha:(CGFloat)alpha;

#pragma mark --创建imageView
+(UIImageView*)createImageViewWithFrame:(CGRect)frame ImageName:(UIImage *)image;

#pragma mark --创建button
+(UIButton*)createButtonWithFrame:(CGRect)frame SetImage:(UIImage *)image SetBackgroundImage:(UIImage *)bgImage Target:(id)target Action:(SEL)action Title:(NSString*)title setBackgroundColorWithSys:(UIColor *)bgColor setTitleColor:(UIColor *)titColor setTag:(int)tag;

+(UIButton*)createButtonWithFrame:(CGRect)frame ImageName:(NSString*)imageName Target:(id)target Action:(SEL)action Title:(NSString*)title setBackgroundColorWithSys:(UIColor *)bgColor setTitleColor:(UIColor *)titColor;


#pragma mark --创建UITextField
+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*)imageView rightImageView:(UIImageView*)rightImageView Font:(float)font backgRoundImageName:(UIImage *)bgImg setText:(NSString *)textStr setTextBorderStyle:(UITextBorderStyle)textBorderStyle setKeyboardType:(UIKeyboardType)keyboardType setTextAlignment:(NSTextAlignment)textAlignment setTag:(NSInteger)tag;

#pragma mark - --判断导航的高度64or44   [[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0
+(float)NavightionHeight;

#pragma mark --颜色转换（颜色对照表   http://cha.buyiju.com/tool/color.html）
+ (UIColor *) colorWithHexString: (NSString *)color;

#pragma mark --将dict转成str
+(NSString *)dictionaryFormatString:(NSDictionary *)toFormatDictionary;

#pragma mark --指定长宽按比例缩放
+(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetSize:(CGSize)imgSize;

#pragma mark --判断是否包含Emoji表情
+ (BOOL)stringContainsEmoji:(NSString *)string;

#pragma mark - 获取磁盘总空间大小
+ (CGFloat)diskOfAllSizeMBytes;

#pragma mark - 获取磁盘可用空间大小
+ (CGFloat)diskOfFreeSizeMBytes;

#pragma mark - 获取指定路径下某个文件的大小
+ (long long)fileSizeAtPath:(NSString *)filePath;

#pragma mark - 获取文件夹下所有文件的大小
+ (long long)folderSizeAtPath:(NSString *)folderPath;

#pragma mark - 获取字符串(或汉字)首字母
+ (NSString *)firstCharacterWithString:(NSString *)string;

#pragma mark - 将字符串数组按照元素首字母顺序进行排序分组
+ (NSDictionary *)dictionaryOrderByCharacterWithOriginalArray:(NSArray *)array;

#pragma mark -  获取当前时间
//format: @"yyyy-MM-dd HH:mm:ss"、@"yyyy年MM月dd日 HH时mm分ss秒"
+ (NSString *)currentDateWithFormat:(NSString *)format;

#pragma mark - 计算上次日期距离现在多久, 如 xx 小时前、xx 分钟前等
/**
 *  计算上次日期距离现在多久
 *
 *  @param lastTime    上次日期(需要和格式对应)
 *  @param format1     上次日期格式
 *  @param currentTime 最近日期(需要和格式对应)
 *  @param format2     最近日期格式
 *
 *  @return xx分钟前、xx小时前、xx天前
 */
+ (NSString *)timeIntervalFromLastTime:(NSString *)lastTime
                        lastTimeFormat:(NSString *)format1
                         ToCurrentTime:(NSString *)currentTime
                     currentTimeFormat:(NSString *)format2;


#pragma mark - 判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile;

#pragma mark -  判断邮箱格式是否正确(利用正则表达式验证)
+ (BOOL)isAvailableEmail:(NSString *)email;

#pragma mark - 对图片进行滤镜处理
// 怀旧 --> CIPhotoEffectInstant                         单色 --> CIPhotoEffectMono
// 黑白 --> CIPhotoEffectNoir                            褪色 --> CIPhotoEffectFade
// 色调 --> CIPhotoEffectTonal                           冲印 --> CIPhotoEffectProcess
// 岁月 --> CIPhotoEffectTransfer                        铬黄 --> CIPhotoEffectChrome
// CILinearToSRGBToneCurve, CISRGBToneCurveToLinear, CIGaussianBlur, CIBoxBlur, CIDiscBlur, CISepiaTone, CIDepthOfField
+ (UIImage *)filterWithOriginalImage:(UIImage *)image filterName:(NSString *)name;

#pragma mark - 对图片进行模糊处理
// CIGaussianBlur ---> 高斯模糊
// CIBoxBlur      ---> 均值模糊(Available in iOS 9.0 and later)
// CIDiscBlur     ---> 环形卷积模糊(Available in iOS 9.0 and later)
// CIMedianFilter ---> 中值模糊, 用于消除图像噪点, 无需设置radius(Available in iOS 9.0 and later)
// CIMotionBlur   ---> 运动模糊, 用于模拟相机移动拍摄时的扫尾效果(Available in iOS 9.0 and later)
+ (UIImage *)blurWithOriginalImage:(UIImage *)image blurName:(NSString *)name radius:(NSInteger)radius;

#pragma mark - 调整图片饱和度、亮度、对比度
/**
 *  调整图片饱和度, 亮度, 对比度
 *
 *  @param image      目标图片
 *  @param saturation 饱和度
 *  @param brightness 亮度: -1.0 ~ 1.0
 *  @param contrast   对比度
 *
 */
+ (UIImage *)colorControlsWithOriginalImage:(UIImage *)image
                                 saturation:(CGFloat)saturation
                                 brightness:(CGFloat)brightness
                                   contrast:(CGFloat)contrast;

#pragma mark - 创建一张实时模糊效果 View (毛玻璃效果)
//Avilable in iOS 8.0 and later
+ (UIVisualEffectView *)effectViewWithFrame:(CGRect)frame;

#pragma mark - 全屏截图
+ (UIImage *)shotScreen;

#pragma mark - 截取一张 view 生成图片
+ (UIImage *)shotWithView:(UIView *)view;

#pragma mark - 截取view中某个区域生成一张图片
+ (UIImage *)shotWithView:(UIView *)view scope:(CGRect)scope;

#pragma mark - 压缩图片到指定尺寸大小
+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size;

#pragma mark - 压缩图片到指定文件大小
+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size;

#pragma mark - 获取设备 IP 地址
//需要先引入下头文件:
//#import <ifaddrs.h>
//#import <arpa/inet.h>
//获取设备 IP 地址
+ (NSString *)getIPAddress;

#pragma mark - 判断字符串中是否含有空格
+ (BOOL)isHaveSpaceInString:(NSString *)string;

#pragma mark -  判断字符串中是否含有某个字符串
+ (BOOL)isHaveString:(NSString *)string1 InString:(NSString *)string2;

#pragma mark - 判断字符串中是否含有中文
+ (BOOL)isHaveChineseInString:(NSString *)string;

#pragma mark -  判断字符串是否全部为数字
+ (BOOL)isAllNum:(NSString *)string;

//统计字数，一个汉字2个字节
+ (NSUInteger)stringLength:(NSString *)str;

#pragma mark - 绘制虚线
/*
 ** lineFrame:     虚线的 frame
 ** length:        虚线中短线的宽度
 ** spacing:       虚线中短线之间的间距
 ** color:         虚线中短线的颜色
 */
+ (UIView *)createDashedLineWithFrame:(CGRect)lineFrame
                           lineLength:(int)length
                          lineSpacing:(int)spacing
                            lineColor:(UIColor *)color;


/**
 *  获取当前屏幕中present出来的viewcontroller
 *
 *  @return Vc
 */
+ (UIViewController *)getPresentedViewController;
/**
 *  获取当前屏幕显示的viewcontroller
 *
 *  @return Vc
 */
+ (UIViewController *)getCurrentVC;

//固定个数的随机字符
+ (NSString * )RandomString:(int)num;
@end




