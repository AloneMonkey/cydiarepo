//
//  SettingsViewController.m
//  MDSettingCenter
//
//  Created by AloneMonkey on 2017/10/26.
//  Copyright © 2017年 MonkeyDev. All rights reserved.
//

#import "MDSettingsViewController.h"
#import "MDConstants.h"
#import "MDColor.h"
#import "MDSuspendBall.h"
#import "FXForms.h"
#import "SettingForm.h"

@interface MDSettingsViewController ()<FXFormControllerDelegate>

@property (nonatomic, strong) MDSuspendBall* suspendBall;

@property (nonatomic, strong) UITableView* tableview;

@property (nonatomic, strong) UILabel* copyright;

@property (nonatomic, strong) UIBarButtonItem *closeButtonItem;

@property (nonatomic, strong) FXFormController *formController;

@end

@implementation MDSettingsViewController

+ (instancetype)sharedInstance {
    static MDSettingsViewController *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MDSettingsViewController alloc] init];
    });
    return instance;
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"插件配置";
    
    self.view.backgroundColor = MDColorBackGround;
    
    [self setupSubViews];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.suspendBall.hidden = YES;
    
    [self.tableview reloadData];
}

#pragma mark - setup view

-(void)setupSubViews{
    _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableview.backgroundColor = MDColorBackGround;
    _tableview.scrollEnabled = YES;
    _tableview.rowHeight = 50;
    _tableview.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_tableview];
    
    _copyright = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MDScreenWidth, 30)];
    _copyright.text = MD_COPYRIGHT;
    _copyright.textColor = MDColorCopyRight;
    _copyright.font = MDFont12;
    _copyright.textAlignment = NSTextAlignmentCenter;
    _tableview.tableFooterView = _copyright;
    
    [self.navigationItem setRightBarButtonItem:[self closeButtonItem]];
    
    self.formController = [[FXFormController alloc] init];
    self.formController.tableView = self.tableview;
    self.formController.delegate = self;
    self.formController.form = [SettingForm sharedInstance];
}

- (UIBarButtonItem *)closeButtonItem {
    if (!_closeButtonItem) {
        UIBarButtonItem *closeButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(MD_DONE, nil) style:UIBarButtonItemStylePlain target:self action:@selector(exit)];
        _closeButtonItem = closeButtonItem;
    }
    return _closeButtonItem;
}

#pragma mark - Getter & Setter

-(MDSuspendBall *)suspendBall{
    if(_suspendBall){
        return _suspendBall;
    }else{
        return [MDSuspendBall sharedInstance];
    }
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - private

-(void)exit{
    self.suspendBall.hidden = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

