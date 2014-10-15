//
//  TipoLuzSelectorViewController.m
//  Maria
//
//  Created by Juan Escudero on 10/1/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "SelectorViewController.h"
#import "Luces.h"
#import "DataManager.h"

@interface SelectorViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation SelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(void)viewDidAppear:(BOOL)animated
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
    return self.datasource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tipoLuzCell" forIndexPath:indexPath];
    
    id element = self.datasource[indexPath.row];
    
    if (self.property_second)
        cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", [element valueForKey:self.property_first], [element valueForKey:self.property_second]];
    else
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [element valueForKey:self.property_first]];
    
    
    if ((indexPath.row % 2) == 0)
    {
        cell.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:244/255.0 alpha:1.0];
    }
    else
    {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}

- (IBAction)seleccionarButtonTapped:(id)sender {
    
    NSInteger row = [self.tableView indexPathForSelectedRow].row;
    id element = self.datasource[row];
    
    if ([self.delegate respondsToSelector:@selector(selectElement:)])
        [self.delegate selectElement:element];
    
}

- (IBAction)cancelarButtonTapped:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(cancelSeleccion)])
        [self.delegate cancelSeleccion];
}


@end
