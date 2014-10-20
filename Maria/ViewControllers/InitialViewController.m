//
//  InitialViewController.m
//  Maria
//
//  Created by Juan Escudero on 9/26/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "InitialViewController.h"
#import "CultivosTableViewController.h"
#import "CultivoViewController.h"
#import "CultivosLogTableViewController.h"

#import "DataManager.h"
#import "RNFrostedSidebar.h"
#import "Usuario.h"

@interface InitialViewController ()<RNFrostedSidebarDelegate, UIAlertViewDelegate, CultivoViewControllerProtocol>

@property (nonatomic, strong) RNFrostedSidebar *sideBar;
@property (nonatomic, strong) CultivoViewController *cultivoVC;
@property (nonatomic, strong) CultivosTableViewController *cultivoTable;
@property (nonatomic, strong) CultivosLogTableViewController *logsVC;

@property (nonatomic, strong) UIViewController *currentVC;
@property (nonatomic, strong) UIViewController *initialVC;


@property (weak, nonatomic) IBOutlet UIView *containerVC;

@end

@implementation InitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem=nil;
    self.navigationItem.hidesBackButton=YES;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"3lines"] style:UIBarButtonItemStylePlain target:self action:@selector(showSideBar)];
    
    DataManager *manager = [[DataManager alloc]init];
    [manager createApplicationObjects];
    
    self.title = @"Cultivos";
    
    
    NSArray *images = @[
                        [UIImage imageNamed:@"cultivo"],
                        [UIImage imageNamed:@"log.jpg"],
                        [UIImage imageNamed:@"camera"],
                        [UIImage imageNamed:@"logout.jpg"]
                        ];
    
    self.sideBar = [[RNFrostedSidebar alloc] initWithImages:images];
    self.sideBar.delegate = self;
    self.sideBar.width = 120;
    
    [self.cultivoTable loadData];
    
    
    self.initialVC = self.childViewControllers.lastObject;
    self.currentVC = self.initialVC;
    self.logsVC = [[UIStoryboard storyboardWithName:@"Logs" bundle:nil]instantiateViewControllerWithIdentifier:@"CultivosLogVC"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"cultivoVC"])
    {
        self.cultivoVC = segue.destinationViewController;
        self.cultivoVC.delegate = self;
    }
    
    if ([segue.identifier isEqualToString:@"cultivosTable"])
    {
        self.cultivoTable = segue.destinationViewController;
        self.currentVC = self.cultivoTable;
        self.initialVC = self.cultivoTable;
    }
}


-(void)cultivoGrabado:(Cultivo*)cultivo
{
    [self.cultivoTable loadData];
}


-(void)showSideBar
{
    [self.sideBar show];
}

- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index{
    
    if (index == 0) {
        [sidebar dismissAnimated:YES];
        
        if (self.cultivoTable != self.currentVC)
        {
            [self.logsVC loadData];
            
            [self addChildViewController:self.cultivoTable];
            self.cultivoTable.view.frame = self.containerVC.bounds;
            
            [self moveToNewController:self.cultivoTable];
        }
        
    }
    
    if (index == 1) {
        [sidebar dismissAnimated:YES];
        
        if (self.logsVC != self.currentVC)
        {
            [self.logsVC loadData];
            
            [self addChildViewController:self.logsVC];
            self.logsVC.view.frame = self.containerVC.bounds;
            self.logsVC.view.frameY = 64;
            
            [self moveToNewController:self.logsVC];
        }
        
    }
    
    if (index == 2) {
        [sidebar dismissAnimated:YES];
        
        if (self.logsVC != self.currentVC)
        {
            [self.logsVC loadData];
            
            [self addChildViewController:self.logsVC];
            self.logsVC.view.frame = self.containerVC.bounds;
            self.logsVC.view.frameY = 64;
            
            [self moveToNewController:self.logsVC];
        }
        
    }

    
    if (index == 3) {
        [sidebar dismissAnimated:YES];
        
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"Maria" message:@"Seguro quiere salir?" delegate:self cancelButtonTitle:@"Si" otherButtonTitles:@"No", nil];
        [alter show];
    }
}


-(void)moveToNewController:(UIViewController *) newController {
    [self.currentVC willMoveToParentViewController:nil];
    [self transitionFromViewController:self.currentVC toViewController:newController duration:.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil
                            completion:^(BOOL finished) {
                                [self.currentVC removeFromParentViewController];
                                [newController didMoveToParentViewController:self];
                                self.currentVC = newController;
                            }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [Usuario logout];
        [self.navigationController.navigationController popViewControllerAnimated:YES];
    }
    
}

@end
