//
//  TipoLuzSelectorViewController.m
//  Maria
//
//  Created by Juan Escudero on 10/1/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "TipoLuzSelectorViewController.h"
#import "Luces.h"
#import "DataManager.h"

@interface TipoLuzSelectorViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet NSObject *tipoIluminacionLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *seleccionarLuzButto;
@property (weak, nonatomic) IBOutlet UIButton *cancelarButton;

@property (nonatomic, strong) Luces* currentLuz;

@property (nonatomic, strong) NSArray *lucesList;

@end

@implementation TipoLuzSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    DataManager *manager = [[DataManager alloc]init];
    self.lucesList = [manager getTiposDeLuz];
    
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
    return self.lucesList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tipoLuzCell" forIndexPath:indexPath];
    
    Luces *luz = ((Luces*)self.lucesList[indexPath.row]);
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", luz.tipo, luz.watts];
    
    return cell;
}

- (IBAction)seleccionarLuzTapped:(id)sender {
    
    NSInteger row = [self.tableView indexPathForSelectedRow].row;
    self.currentLuz = ((Luces*)self.lucesList[row]);
    
    if ([self.delegate respondsToSelector:@selector(seleccionTipoIluminacion:)])
        [self.delegate seleccionTipoIluminacion:self.currentLuz];
    
}

- (IBAction)cancelarButtonTapped:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(cancelLuzSeleccion)])
        [self.delegate cancelLuzSeleccion];
}


@end
