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
#import "UIView+AutoLayout.h"

@interface ViewController ()

@property(strong,nonatomic)UIPageViewController* pageViewController;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property(strong,nonatomic)NSArray<NSString*>* viewControllerNames;

@property(strong,nonatomic)NSNumber* nextPageNumber;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    [self addChildViewController:self.pageViewController];
    //Make the frame take up the whole space
    [self.pageViewController.view setFrame:CGRectMake(0, 0, [[self view] bounds].size.width, [[self view] bounds].size.height + 37)];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    [self.view bringSubviewToFront:self.pageControl];
    
    self.viewControllerNames = @[NSStringFromClass([ViewControllerA class]),NSStringFromClass([ViewControllerB class]),NSStringFromClass([ViewControllerC class])];
    UIViewController* a = [[NSClassFromString(self.viewControllerNames[0]) alloc]init];
    
    a.pageNumber = [NSNumber numberWithInteger:0];
    
    [self.pageViewController setViewControllers:@[a] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    
    UIPageControl *pageControlAppearance = [UIPageControl appearanceWhenContainedInInstancesOfClasses:@[[UIPageViewController class]]];
    pageControlAppearance.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControlAppearance.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    //pageControlAppearance.backgroundColor = [UIColor clearColor];
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
//Implementing these gives you a UIPageControl for free
-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    
    return [self.viewControllerNames count];
}
//the first view controller to show
-(NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
    return 0;
}

#pragma mark - UIPageViewControllerDelegate

-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{
    self.nextPageNumber = [pendingViewControllers lastObject].pageNumber;
}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if(completed){
        self.pageControl.currentPage = [self.nextPageNumber intValue];
    }
}


@end
