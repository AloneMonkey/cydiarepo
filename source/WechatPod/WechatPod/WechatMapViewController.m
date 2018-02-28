//
//  MDMapViewController.m
//  MDMapView
//
//  Created by AloneMonkey on 2017/11/2.
//  Copyright © 2017年 MonkeyDev. All rights reserved.
//

#import "WechatMapViewController.h"
#import "WechatPodForm.h"
#import <MapKit/MapKit.h>

@interface WechatMapViewController()<MKMapViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) MKPointAnnotation* mapPoint;
@property (nonatomic, strong) UIBarButtonItem* backButtonItem;
@property (nonatomic, strong) UIBarButtonItem* closeButtonItem;

@end

@implementation WechatMapViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _mapPoint = [[MKPointAnnotation alloc] init];
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self setupSubviews];
}

-(void)setupSubviews{
    self.title = @"我的位置";
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    gesture.delegate = self;
    [_mapView addGestureRecognizer:gesture];
    [self.view addSubview:_mapView];
    
    self.navigationItem.leftBarButtonItem = self.backButtonItem;
    self.navigationItem.rightBarButtonItem = self.closeButtonItem;
}

- (void)click:(UITapGestureRecognizer*) gesture{
    if(gesture){
        [_mapView removeAnnotations:_mapView.annotations];
        CGPoint point = [gesture locationInView:_mapView];
        CLLocationCoordinate2D location = [_mapView convertPoint:point toCoordinateFromView:_mapView];
        [_mapPoint setCoordinate:location];
        [_mapView addAnnotation:_mapPoint];
        
//        self.field.value    
        
        pluginConfig.location = location;
        
        self.title = [NSString stringWithFormat:@"%0.3f, %0.3f",
                      location.latitude, location.longitude];
    }
}

- (UIBarButtonItem *)backButtonItem {
    if (!_backButtonItem) {
        UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        _backButtonItem = backButtonItem;
    }
    return _backButtonItem;
}

- (UIBarButtonItem *)closeButtonItem {
    if (!_closeButtonItem) {
        UIBarButtonItem *closeButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"清除位置" style:UIBarButtonItemStylePlain target:self action:@selector(clearAndExit)];
        _closeButtonItem = closeButtonItem;
    }
    return _closeButtonItem;
}

-(void)back{
    if(self.navigationController){
        [self.navigationController popViewControllerAnimated:YES];
    }else if([self presentedViewController]){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    _mapView.userTrackingMode  = MKUserTrackingModeNone;
    _mapView.showsUserLocation = NO;
    [_mapView removeAnnotations:_mapView.annotations];
    _mapView.delegate = nil;
}

-(void)clearAndExit{
    pluginConfig.location = CLLocationCoordinate2DMake(0,0);
    [self back];
}

@end
