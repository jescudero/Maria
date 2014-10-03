//
//  FechaSelectorViewController.m
//  Maria
//
//  Created by Juan Escudero on 10/3/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "FechaSelectorViewController.h"

@interface FechaSelectorViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleVC;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation FechaSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.datePicker.date = [NSDate date];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelTapped:(id)sender {

    if ([self.delegate respondsToSelector:@selector(cancelFecha)])
        [self.delegate cancelFecha];
}

- (IBAction)seleccionTapped:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(selectFecha:)])
        [self.delegate selectFecha:self.datePicker.date];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
