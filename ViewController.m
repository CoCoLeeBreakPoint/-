//
//  ViewController.m
//  计算器
//
//  Created by 知客 on 2017/3/23.
//  Copyright © 2017年 TR. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)UIButton *NBtn; //数字按钮
@property(nonatomic,strong)UIButton *SymbolBtn; //符号按钮
@property(nonatomic,strong)UIButton *ResultBtn;//结果按钮
@property(nonatomic,strong)UIButton *CleanBtn;//清除按钮
@property(nonatomic,strong)UILabel *ShowLabel; //显示窗口
@property(nonatomic,strong)NSMutableString *ChangerStr; //可变的字符
@property(nonatomic,assign)double num1,num2,num3,num4;





@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _ChangerStr =[[NSMutableString alloc]init];//初始化
    
    
    [self ShowLabel]; //懒加载显示窗口
    [self UpNBtn]; //加载数字按钮
    [self UpSymbolBtn];//加载符号按钮
    [self UpResultBtn];//加载等于按钮
    [self UpCleanBtn];//加载清除按钮
}


//数字按钮
-(void)UpNBtn{
    int n = 0;
    NSArray *NumArr =[NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    
    for (int i=0; i<3; i++)
    {
        for (int j = 0; j<3; j++) {
            _NBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            _NBtn.frame = CGRectMake(10+60*j, 80+60*i, 45, 45);
            _NBtn.backgroundColor=[UIColor grayColor];
            [_NBtn setTitle:[NumArr objectAtIndex:n++] forState:UIControlStateNormal];
            [_NBtn addTarget:self action:@selector(shuzi:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:_NBtn];
        }
    }
    
}

//清除按钮
-(void)UpCleanBtn{
    _CleanBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _CleanBtn.backgroundColor =[UIColor grayColor];
    _CleanBtn.frame =CGRectMake(10, 260, 45, 45);
    [_CleanBtn setTitle:@"清除" forState:UIControlStateNormal];
    [_CleanBtn addTarget:self action:@selector(Clean:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_CleanBtn];
}

//等于按钮
-(void)UpResultBtn{
        _ResultBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _ResultBtn.backgroundColor =[UIColor grayColor];
        _ResultBtn.frame= CGRectMake(210, 200, 90, 45);
        [_ResultBtn setTitle:@"=" forState:UIControlStateNormal];
        [_ResultBtn addTarget:self action:@selector(Go:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_ResultBtn];
}

//符号按钮
-(void)UpSymbolBtn{
    int m =0;
    NSArray *SymArr =[NSArray arrayWithObjects:@"+",@"-",@"*",@"/",nil];
    for (int i = 0; i <2; i++)
    {
        for (int j = 0; j<2; j++) {
            _SymbolBtn =[UIButton buttonWithType:UIButtonTypeCustom];
            _SymbolBtn.backgroundColor =[UIColor grayColor];
            _SymbolBtn.frame= CGRectMake(200+60*j, 80+60*i, 45, 45);
            [_SymbolBtn setTitle:[SymArr objectAtIndex:m++] forState:UIControlStateNormal];
            [_SymbolBtn addTarget:self action:@selector(Fuhao:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:_SymbolBtn];
        }
    }
    
}



//数字按钮事件
-(void)shuzi:(id)sender{
    
    if ([self.ChangerStr hasPrefix:@"+"]||[self.ChangerStr hasPrefix:@"-"]||[self.ChangerStr hasPrefix:@"*"]||[self.ChangerStr hasPrefix:@"/"])
    {
        [self.ChangerStr setString:@""];
    }
    
    [self.ChangerStr appendString:[sender currentTitle]];//拼接数字
    self.ShowLabel.text = [NSString stringWithString:self.ChangerStr]; //显示
    self.num1 =[self.ShowLabel.text doubleValue]; //保存数字
    

}

//符号按钮事件
-(void)Fuhao:(id)sender{
    [self.ChangerStr setString:@""];
    [self.ChangerStr appendString:[sender currentTitle]];
    if ([self.ChangerStr hasPrefix:@"+"])
    {
        self.num2 = self.num1;
        self.num4 = 1;
    }
    else if ([self.ChangerStr hasPrefix:@"-"])
    {
        self.num2 = self.num1;
        self.num4 = 2;
    }
    else if ([self.ChangerStr hasPrefix:@"*"])
    {
        self.num2 = self.num1;
        self.num4 = 3;
    }
    else if ([self.ChangerStr hasPrefix:@"/"])
    {
        self.num2 = self.num1;
        self.num4 = 4;
    }

    
}

//清除按钮事件
-(void)Clean:(id)sender{
    [self.ChangerStr setString:@""];
    self.num1 = 0;
    self.num2 = 0;
    self.ShowLabel.text =[NSString stringWithString:self.ChangerStr];
    
}

//计算事件
-(void)Go:(id)sender{
    
    if (self.num4 ==1 )
    {
        self.num3 = self.num2+[self.ShowLabel.text doubleValue];
        self.ShowLabel.text =[NSString stringWithFormat:@"%f",self.num3];
        self.num1 =[self.ShowLabel.text doubleValue];
        self.num3 = 0;
        [self.ChangerStr setString:@""];
        
        
    }
    else if (self.num4 ==2)
    {
        self.num3 = self.num2-[self.ShowLabel.text doubleValue];
        self.ShowLabel.text =[NSString stringWithFormat:@"%f",self.num3];
        self.num1 =[self.ShowLabel.text doubleValue];
        self.num3 = 0;
        [self.ChangerStr setString:@""];
    }
    else if (self.num4 ==3)
    {
        self.num3 = self.num2*[self.ShowLabel.text doubleValue];
        self.ShowLabel.text =[NSString stringWithFormat:@"%f",self.num3];
        self.num1 =[self.ShowLabel.text doubleValue];
        self.num3 = 0;
        [self.ChangerStr setString:@""];
    }
    else if (self.num4 ==4)
    {
        self.num3 = self.num2/[self.ShowLabel.text doubleValue];
        self.ShowLabel.text =[NSString stringWithFormat:@"%f",self.num3];
        self.num1 =[self.ShowLabel.text doubleValue];
        self.num3 = 0;
        [self.ChangerStr setString:@""];
    }



}

//显示窗口
-(UILabel*)ShowLabel{
    if (!_ShowLabel) {
        _ShowLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 30, self.view.frame.size.width-20, 40)];
        _ShowLabel.backgroundColor =[UIColor grayColor];
        _ShowLabel.layer.cornerRadius =20;
        _ShowLabel.layer.masksToBounds =YES;
        [self.view addSubview:_ShowLabel];
        
    }
    return _ShowLabel;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
