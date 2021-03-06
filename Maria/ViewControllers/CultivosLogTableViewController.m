//
//  CultivosLogTableViewController.m
//  Maria
//
//  Created by Juan Escudero on 10/16/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "CultivosLogTableViewController.h"
#import "CultivosLogTableViewCell.h"
#import "CultivoLogHeaderView.h"
#import "Cultivo.h"
#import "Armario.h"
#import "ArmarioLogViewController.h"
#import "LogTableViewController.h"

@interface CultivosLogTableViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSArray *cultivosList;

@end

@implementation CultivosLogTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self loadData];
}

-(void)loadData
{
    self.cultivosList = [Cultivo all];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return self.cultivosList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    Cultivo *cultivo = self.cultivosList[section];
    
    return cultivo.armarios.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CultivosLogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cultivosLogCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Armario *armario = [((Cultivo*)self.cultivosList[indexPath.section]).armarios allObjects][indexPath.row];
    
    [cell configureView:armario];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    Cultivo *cultivo = self.cultivosList[section];
    
    CultivoLogHeaderView *cultivoHeader = [[[NSBundle mainBundle] loadNibNamed:@"CultivoLogHeader" owner:self options:nil] objectAtIndex:0];

    [cultivoHeader configureView:cultivo];
    cultivoHeader.tag = section;
    
    UITapGestureRecognizer *singleTapRecogniser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureHandler:)];
    [singleTapRecogniser setDelegate:self];
    singleTapRecogniser.numberOfTouchesRequired = 1;
    singleTapRecogniser.numberOfTapsRequired = 1;
    [cultivoHeader addGestureRecognizer:singleTapRecogniser];
    
    return cultivoHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    ArmarioLogViewController *logVC = [[UIStoryboard storyboardWithName:@"Logs" bundle:nil]instantiateViewControllerWithIdentifier:@"LogsVC"];
    
    Armario *armario = [((Cultivo*)self.cultivosList[indexPath.section]).armarios allObjects][indexPath.row];
    
    logVC.armario = armario;

    [self.navigationController pushViewController:logVC animated:YES];
}

-(void)gestureHandler:(UITapGestureRecognizer*)gesture
{
    LogTableViewController *logTableVC = [[UIStoryboard storyboardWithName:@"Logs" bundle:nil]instantiateViewControllerWithIdentifier:@"LogsTableVC"];
    
    NSInteger section = gesture.view.tag;
    
    logTableVC.cultivo = self.cultivosList[section];
    
    [self.navigationController pushViewController:logTableVC animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.    

}


@end
