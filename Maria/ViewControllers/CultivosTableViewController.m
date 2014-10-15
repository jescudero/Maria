//
//  CultivosTableViewController.m
//  Maria
//
//  Created by Juan Escudero on 9/29/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "CultivosTableViewController.h"
#import <CoreData/CoreData.h>
#import "CultivoViewController.h"
#import "Cultivo.h"

@interface CultivosTableViewController ()

@property (nonatomic, strong) NSArray *cultivosList;

@property (nonatomic, strong) Cultivo *cultivo;

@end

@implementation CultivosTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


-(void)loadData
{
    self.cultivosList = [Cultivo all];
    
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.cultivosList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cultivoCell" forIndexPath:indexPath];
    
    Cultivo *cultivo = self.cultivosList[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %d", cultivo.nombre, cultivo.armarios.count];

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        Cultivo *cultivo = self.cultivosList[indexPath.row];
        [cultivo delete];
        [cultivo save];
        
        self.cultivosList = [Cultivo all];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }  
}


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
    
    if ([segue.identifier isEqualToString:@"cultivoDetail"])
    {
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        self.cultivo = self.cultivosList[selectedRowIndex.row];
        ((CultivoViewController*)segue.destinationViewController).cultivo = self.cultivo;

    }
        
    
    
}

@end
