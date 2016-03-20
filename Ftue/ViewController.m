//
//  ViewController.m
//  Ftue
//
//  Created by Spencer Kamchee on 3/20/16.
//  Copyright © 2016 spencerkamchee. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerA.h"
#import "ViewControllerB.h"
#import "ViewControllerC.h"
#import "UIViewController+Page.h"

@interface ViewController ()

@property(strong,nonatomic)UIPageViewController* pageViewController;

@property(strong,nonatomic)NSArray<NSString*>* viewControllerNames;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.dataSource = self;
    
    [self addChildViewController:self.pageViewController];
    self.pageViewController.view.frame = self.view.bounds;
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    self.viewControllerNames = @[NSStringFromClass([ViewControllerA class]),NSStringFromClass([ViewControllerB class]),NSStringFromClass([ViewControllerC class])];
    UIViewController* a = [[NSClassFromString(self.viewControllerNames[0]) alloc]init];
    
    a.pageNumber = [NSNumber numberWithInteger:0];
    
    [self.pageViewController setViewControllers:@[a] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    
    UIPageControl *pageControlAppearance = [UIPageControl appearanceWhenContainedInInstancesOfClasses:@[[UIPageViewController class]]];
    pageControlAppearance.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControlAppearance.currentPageIndicatorTintColor = [UIColor darkGrayColor];
}

#pragma mark - UIPageViewControllerDatasource

-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    int p = [viewController.pageNumber intValue];
    if(p==self.viewControllerNames.count-1){
        return nil;
    }
    
    UIViewController* vc = [[NSClassFromString(self.viewControllerNames[p+1]) alloc]init];
    vc.pageNumber = [NSNumber numberWithInt:p+1];
    return vc;
}

-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    int p = [viewController.pageNumber intValue];
    if(p==0){
        return nil;
    }
    UIViewController* vc = [[NSClassFromString(self.viewControllerNames[p-1]) alloc]init];
    vc.pageNumber = [NSNumber numberWithInt:p-1];
    return vc;
}

//Only called once after setViewControllers:direction:animated:completion:
//These two items are expected to remain constant once the page view has been created. See Apple doc

-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    
    return [self.viewControllerNames count];
}

-(NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
    return 0;
}


@end
