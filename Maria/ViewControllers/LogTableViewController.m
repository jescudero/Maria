//
//  LogTableViewController.m
//  Maria
//
//  Created by Juan Escudero on 11/30/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "LogTableViewController.h"
#import "Cultivo.h"
#import "Armario.h"
#import "Planta.h"
#import "EventoArmario.h"
#import "EventoPlanta.h"
#import "LogTableViewCell.h"

@interface LogTableViewController ()

@property (nonatomic, strong) NSMutableArray* eventos;

@end

@implementation LogTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Seguimiento Cultivo";
    
    self.tableView.estimatedRowHeight = 50;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.eventos = [[NSMutableArray alloc]init];
    
    NSMutableArray *eventosArmario = [[NSMutableArray alloc]init];
    NSArray *eventosArmarioSort = [[NSArray alloc]init];
    NSMutableArray *eventosPlanta = [[NSMutableArray alloc]init];
    NSArray *eventosPlantaSort = [[NSArray alloc]init];
    
    for (Armario * armario in self.cultivo.armarios){
        
        for (EventoArmario *evento in armario.eventos) {
            [eventosArmario addObject:evento];
        }
        
        for (Planta *planta in armario.plantas) {
            for (EventoPlanta *evento in planta.eventos) {
                [eventosPlanta addObject:evento];
            }
        }
    }
    
    
    if (eventosArmario.count > 0)
    {
        eventosArmarioSort = [eventosArmario sortedArrayUsingComparator: ^(EventoArmario *obj1, EventoArmario *obj2) {
            return [obj2.fecha compare:obj1.fecha];
        }];
        
        eventosPlantaSort = [eventosPlanta sortedArrayUsingComparator: ^(EventoPlanta *obj1, EventoPlanta *obj2) {
            return [obj2.fecha compare:obj1.fecha];
        }];
    }
    
    
    if (eventosArmarioSort.count > eventosPlantaSort.count)
    {
        int i = 0;
        int j = 0;
        while ((i < eventosArmarioSort.count) && (j< eventosPlantaSort.count)) {
            
            if ([((EventoArmario*)eventosArmarioSort[i]).fecha compare:((EventoPlanta*)eventosPlantaSort[j]).fecha] == NSOrderedAscending)
            {
                [self.eventos addObject:eventosPlantaSort[j]];
                j++;
            }
            else
            {
                [self.eventos addObject:eventosArmarioSort[i]];
                i++;
            }
        }
        
        if (j < eventosPlantaSort.count)
        {
            for (int x = j; x<eventosPlantaSort.count; x++) {
                [self.eventos addObject:eventosPlantaSort[x]];
            }
        }
        
        if (i < eventosArmarioSort.count)
        {
            for (int x = i; x<eventosArmarioSort.count; x++) {
                [self.eventos addObject:eventosArmarioSort[x]];
            }
        }
    }
    else
    {
        int i = 0;
        int j = 0;
        while ((i < eventosPlantaSort.count) && (j < eventosArmarioSort.count)) {
            
            if ([((EventoPlanta*)eventosPlantaSort[i]).fecha compare:((EventoArmario*)eventosArmarioSort[j]).fecha] == NSOrderedAscending)
            {
                
                [self.eventos addObject:eventosArmarioSort[j]];
                j++;
            }
            else
            {
                [self.eventos addObject:eventosPlantaSort[i]];
                i++;
            }
        }
        
        if (j < eventosArmarioSort.count)
        {
            for (int x = j; x<eventosArmarioSort.count; x++) {
                [self.eventos addObject:eventosArmarioSort[x]];
            }
        }
        
        if (i < eventosPlantaSort.count)
        {
            for (int x = i; x<eventosPlantaSort.count; x++) {
                [self.eventos addObject:eventosPlantaSort[x]];
            }
        }
    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    return self.eventos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LogTVCell" forIndexPath:indexPath];
    

    if ([self.eventos[indexPath.row] isKindOfClass:[EventoArmario class]])
        [cell configureCellEventoArmario:self.eventos[indexPath.row]];
    else
        [cell configureCellEventoPlanta:self.eventos[indexPath.row]];
        
    return cell;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
