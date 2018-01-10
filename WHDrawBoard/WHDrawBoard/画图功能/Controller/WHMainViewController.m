//
//  WHMainViewController.m
//  WHDrawBoard
//
//  Created by wang on 2017/10/12.
//  Copyright © 2017年 wang. All rights reserved.
//

#import "WHMainViewController.h"
#import "WHDrawView.h"
#import "WHTopFuntionView.h"
#import "WHLineWidthView.h"
#import "WHLineColorView.h"
#import "WHPickView.h"
#import "WHResultView.h"

#import "WHTitleModel.h"


@interface WHMainViewController ()<UITextFieldDelegate,WHPickDelegate>

@property (strong,nonatomic)WHDrawView * drawView;

@property (strong,nonatomic)WHTopFuntionView * topView;//上部工具栏

@property (strong,nonatomic)WHLineWidthView * lineView;//线宽view

@property (strong,nonatomic)WHLineColorView * lineColor;//线颜色view

@property (strong,nonatomic)NSMutableArray * dataArray;

@property (strong,nonatomic)UITextField * inputText;

@property (strong,nonatomic)WHResultView * resultView;

@property (copy,nonatomic)NSString * tip;//提示

@end

@implementation WHMainViewController
{
    NSString * _answerStr;//答案
    UIView * backView;//输入答案的view
    ShowType _type;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setdata];
    [self layoutViews];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)layoutViews{
    
    _drawView = [[WHDrawView alloc]initWithFrame:CGRectMake(0, 42, ViewWidth, ViewHeight)];
    [self.view addSubview:_drawView];
    
    _topView = [[WHTopFuntionView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, 42)];
    [self.view addSubview:_topView];
    @WHWeakSelf(self);
    //list
    //获取随机画图信息
    [_topView setListB:^{
        NSMutableArray * contentArray = [NSMutableArray arrayWithCapacity:0];
        NSInteger index = arc4random()%8;
        for (int i=0; i<4; i++) {
            NSInteger add = 1+arc4random()%8;
            index += add;
            [contentArray addObject:Weakself.dataArray[index]];
        }
        WHPickView * pickView = [[WHPickView alloc]initThePickTableWithSouceArr:contentArray andSelectBlock:^(WHTitleModel *model) {
            _answerStr = model.drawName;
            _tip = model.tip;
            Weakself.drawView.tipLabel.text = FORMAT(@"关键提示：%@",Weakself.tip);
        }];
        pickView.delegate = Weakself;
    }];
    //clean
    [_topView setCleanB:^{
        [Weakself.drawView clean];
    }];
    //undo
    [_topView setUndoB:^{
        [Weakself.drawView undo];
    }];
    //redo
    [_topView setRedoB:^{
        [Weakself.drawView redo];
    }];
    //done
    [_topView setDoneB:^{
        [Weakself setUpBackViewWithType:AnswerType];
    }];
    //线宽view
    _lineView = [[WHLineWidthView alloc]initWithFrame:CGRectMake(0, ViewHeight-60, 270, 60)];
    [_lineView setBlock:^(CGFloat width) {
        [Weakself.drawView setWidth:width];
    }];
    [self.view addSubview:_lineView];
    //线颜色view
    _lineColor = [[WHLineColorView alloc]initWithFrame:CGRectMake(ViewWidth-60, ViewHeight-60*7, 60, 60*7)];
    [_lineColor setBlock:^(UIColor *color) {
        [Weakself.drawView setColor:color];
    }];
    [self.view addSubview:_lineColor];
}

-(void)setUpBackViewWithType:(ShowType)type{
    _type = type;
    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight)];
    backView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.6];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressToHiden)];
    [backView addGestureRecognizer:tap];
    
    [self.view addSubview:backView];
    
    UIView * centerView = [[UIView alloc]init];
    centerView.backgroundColor = [UIColor whiteColor];
    centerView.layer.cornerRadius = 2;
    centerView.clipsToBounds = YES;
    [backView addSubview:centerView];
    
    UILabel * titlelabel = [[UILabel alloc]init];
    titlelabel.font = WHFont(15.0);
    titlelabel.textColor = WHRGBColor(153, 153, 153);
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.text = @"请输入您的答案";
    if (type==InputNameType) {
        titlelabel.text = @"请输入你想出的题目";
    }else if (type==InputTipsType){
        titlelabel.text = @"请输入对应的提示";
    }
    [centerView addSubview:titlelabel];
    
    [centerView addSubview:self.inputText];
    
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:WHRGBColor(52, 52, 52) forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(pressToCancel) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn.titleLabel setFont:WHFont(15.0)];
    cancelBtn.layer.cornerRadius = 2;
    cancelBtn.layer.borderColor = WHRGBColor(237, 237, 237).CGColor;
    cancelBtn.layer.borderWidth = 1;
    cancelBtn.clipsToBounds = YES;
    [centerView addSubview:cancelBtn];
    
    UIButton * doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.backgroundColor = WHRGBColor(52, 52, 52);
    NSString * btntittle = @"确定";
    if (type==InputNameType) {
        btntittle = @"下一步";
    }
    [doneBtn setTitle:btntittle forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(pressToDone) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn.titleLabel setFont:WHFont(15.0)];
    doneBtn.layer.cornerRadius = 2;
    doneBtn.clipsToBounds = YES;
    [centerView addSubview:doneBtn];
    
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.equalTo(@194);
        make.size.mas_equalTo(CGSizeMake(307, 172));
    }];
    
    [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(centerView);
        make.top.equalTo(@18);
        make.height.equalTo(@16);
    }];
    
    [_inputText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@26);
        make.top.mas_equalTo(titlelabel.mas_bottom).with.offset(18);
        make.right.equalTo(@-26);
        make.height.equalTo(@40);
    }];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_inputText);
        make.bottom.equalTo(@-12);
        make.size.mas_equalTo(CGSizeMake(117, 40));
    }];;
    
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-26);
        make.bottom.equalTo(@-12);
        make.size.mas_equalTo(cancelBtn);
    }];
}

-(void)showResultViewWithSuccess:(BOOL)success{
    WHResultType type = success ? BingoType: FalseType;
    _resultView = [[WHResultView alloc]initWithFrame:self.view.bounds andType:type];
    @WHWeakSelf(self);
    [_resultView setSaveB:^{
        [Weakself pressToSaveTheImage];
    }];
    [self.view addSubview:_resultView];
}

-(void)setdata{
    //工程自身的plist
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"drawTitle" ofType:@"plist"];
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    NSArray * sourceArr = dataDic[@"content"];
    for (NSDictionary * dic in sourceArr) {
        WHTitleModel * model = [[WHTitleModel alloc]initWithDictionary:dic];
        [self.dataArray addObject:model];
    }
}

-(void)pressToCancel{
    _inputText.text = @"";
    [backView removeFromSuperview];
}

-(void)pressToDone{
    if (_type==InputNameType) {
        _answerStr = _inputText.text;
        _inputText.text = @"";
        [backView removeFromSuperview];
        [self setUpBackViewWithType:InputTipsType];
        return;
    }
    if (_type==InputTipsType) {
        _tip = _inputText.text;
        self.drawView.tipLabel.text = FORMAT(@"关键提示：%@",self.tip);
        _inputText.text = @"";
        [self.view makeCenterToast:@"出题成功"];
    }else{
        if ([_inputText.text isEqualToString:_answerStr]) {
            [self showResultViewWithSuccess:YES];
        }else{
            [self showResultViewWithSuccess:NO];
        }
    }
    [backView removeFromSuperview];
    _inputText.text = @"";
}

-(void)pressToHiden{
    _inputText.text = @"";
    [backView removeFromSuperview];
}

#pragma mark - pick代理
-(void)checkToInputTheDrawName{
    //展示
    [self setUpBackViewWithType:InputNameType];
    NSLog(@"1");
}

#pragma mark- 图片保存到相册
-(void)pressToSaveTheImage{
    UIImage * image = [self getImageFromView:self.drawView];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSaveToAlbum:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)imageSaveToAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(id)contextInfo{
    NSString* message;
    if (!error) {
        message = @"已经成功保存到相册";
    }else{
        message = [error description];
    }
    [self.resultView removeFromSuperview];
    [self.view makeToast:message];
}
    
-(UIImage *)getImageFromView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(UITextField *)inputText{
    if (!_inputText) {
        _inputText = [[UITextField alloc]init];
        _inputText.backgroundColor = WHRGBColor(237, 237, 237);
        _inputText.tintColor = WHRGBColor(53, 53, 53);
        _inputText.textColor= WHRGBColor(53, 53, 53);
        _inputText.font = WHFont(15.0);
        _inputText.delegate = self;
        _inputText.textAlignment = NSTextAlignmentCenter;
        _inputText.layer.cornerRadius = 2;
        _inputText.clipsToBounds = YES;
    }
    return _inputText;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return  _dataArray;
}


@end
