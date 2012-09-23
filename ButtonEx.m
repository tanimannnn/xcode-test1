//
//  ButtonEx.m
//  ButtonEx
//
//  Created by 真広 大谷 on 12/09/01.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ButtonEx.h"

#define BTN_ALERT 0
#define BTN_YESNO 1
#define BTN_SHEET 2
#define BTN_IMAGE 3
#define BTN_DETAIL 4

@implementation ButtonEx

// アラートの表示 
- (void)showAlert:(NSString*)title text:(NSString*)text {
    UIAlertView* alert = [[[UIAlertView alloc]
        initWithTitle:title message:text 
        delegate:nil 
        cancelButtonTitle:@"OK" 
        otherButtonTitles:nil] autorelease];
    [alert show];
                        
}

// YES/NO 
- (void)showYesNoDialog:(NSString*)title text:(NSString*)text {
    UIAlertView* alert = [[[UIAlertView alloc]
        initWithTitle:title 
        message:text delegate:self 
        cancelButtonTitle:@"No" 
        otherButtonTitles:@"Yes", nil] autorelease];
    [alert show];
}

// テキストボタンの生成
- (UIButton*)makeButton:(CGRect)rect text:(NSString*)text tag:(int)tag {
    // make text (1)
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:rect];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTag:tag];
    
    // eventlistener set
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

// イメージボタンの生成
- (UIButton*)makeButton:(CGRect)rect image:(UIImage*)image tag:(int)tag {
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:rect];
    [button setImage:image forState:UIControlStateNormal];
    [button setTag:tag];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

// 詳細ボタンの生成
- (UIButton*)makeDetailButton:(CGRect)rect tag:(int)tag {
    UIButton* button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [button setFrame:rect];
    [button setTag:tag];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}


/** 不要
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/


// 初期化
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    // アラートボタンの生成(1)
    UIButton* btnAlert = [self makeButton:CGRectMake(60, 20, 200, 40) text:@"アラート表示！" tag:BTN_ALERT];
    // イベントリスナーの指定
    [btnAlert addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //　コンポーネントの追加
    [self.view addSubview:btnAlert];
    
    // YES/NOダイアログの生成
    UIButton* btnYesNo = [self makeButton:CGRectMake(60, 70, 200, 40) text:@"Yes/Noダイアログ表示？" tag:BTN_YESNO];
    [self.view addSubview:btnYesNo];
    
    // アクションシートの表示ボタン
    UIButton* btnSheet = [self makeButton:CGRectMake(60, 120, 200, 40) text:@"アクションシートの表示" tag:BTN_SHEET];
    [self.view addSubview:btnSheet];
    
    // イメージボタンの生成
    UIButton* btnImage = [self makeButton:CGRectMake(60, 170, 114, 114) 
                                image:[UIImage imageNamed:@"kameo.png"] tag:BTN_IMAGE];
    [self.view addSubview:btnImage];
    
    // 詳細ボタンの生成
    UIButton* btnDetail = [self makeDetailButton:CGRectMake(0, 220, 30, 30) tag:BTN_DETAIL];
    [self.view addSubview:btnDetail];
    
}

// ボタンクリック時に呼ばれる
- (IBAction)clickButton:(UIButton*)sender {
    if (sender.tag == BTN_ALERT) {
        // アラーと表示
        [self showAlert:@"" text:@"アラートボタンを押した"];
    } else if (sender.tag == BTN_YESNO) {
        [self showYesNoDialog:@"" text:@"YES/NOボタンを押した？"];
    } else if (sender.tag == BTN_SHEET) {
        UIActionSheet* sheet = [[[UIActionSheet alloc]
            initWithTitle:@"アクションシートの表示" 
            delegate:self
            cancelButtonTitle:@"キャンセル" 
            destructiveButtonTitle:@"もうおわりだぁ！" 
            otherButtonTitles:@"項目１", @"項目２", @"項目３", nil]
            autorelease];
        [sheet showInView:self.view];
    } else if(sender.tag == BTN_IMAGE) {
        // アラートの表示
        [self showAlert:@"" text:@"今...なにかしたか?"];
    } else if(sender.tag == BTN_DETAIL) {
        [self showAlert:@"" text:@"特に何もないが"];
    }
}

// アラーとボタンクリック時の呼ばれる
- (void)alertView:(UIAlertView*)alertView didDismissWithButtonIndex:(NSInteger)index {
    NSString* text = [NSString stringWithFormat:@"項目%dをクリック", index];
    [self showAlert:@"" text:text];
}

// アクションシートボタンクリック時に呼ばれる
- (void)actionSheet:(UIActionSheet*)actionSheet didDismissWithButtonIndex:(NSInteger)index {
    if (index != 0 && index != 4) {
        NSString* text = [NSString stringWithFormat:@"項目%dをクリック", index];
        [self showAlert:@"" text:text];
    }
   
}

// 画面を端末の向きに合わせて回転
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
