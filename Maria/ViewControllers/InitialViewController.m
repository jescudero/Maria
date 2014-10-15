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
#import "DataManager.h"
#import "RNFrostedSidebar.h"
#import "Usuario.h"

@interface InitialViewController ()<RNFrostedSidebarDelegate, UIAlertViewDelegate, CultivoViewControllerProtocol>

@property (nonatomic, strong) RNFrostedSidebar *sideBar;
@property (nonatomic, strong) CultivoViewController *cultivoVC;
@property (nonatomic, strong) CultivosTableViewController *cultivoTable;

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
    [self.sideBar show];
    
    [self.cultivoTable loadData];

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
    if (index == 3) {
        [sidebar dismissAnimated:YES];
        
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"Maria" message:@"Seguro quiere salir?" delegate:self cancelButtonTitle:@"Si" otherButtonTitles:@"No", nil];
        [alter show];
    }
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
