//
//  CultivoViewController.m
//  Maria
//
//  Created by Juan Escudero on 9/30/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "CultivoViewController.h"
#import <CoreData/CoreData.h>
#import "Cultivo.h"
#import "ArmarioViewController.h"
#import "FechaSelectorViewController.h"
#import "Armario.h"
#import <QuartzCore/QuartzCore.h> 
#import "ErrorViewController.h"

@interface CultivoViewController ()<UITextViewDelegate, AgregarArmarioProtocol, FechaSelectorProtocol>

@property (weak, nonatomic) IBOutlet UILabel *nombreLabel;
@property (weak, nonatomic) IBOutlet UILabel *fechaLabel;
@property (weak, nonatomic) IBOutlet UILabel *armariosLabel;
@property (weak, nonatomic) IBOutlet UILabel *notasLabel;
@property (weak, nonatomic) IBOutlet UITextField *nombreText;
@property (weak, nonatomic) IBOutlet UITextField *fechaText;
@property (weak, nonatomic) IBOutlet UITextView *notasText;
@property (weak, nonatomic) IBOutlet UIButton *addArmarioButton;
@property (weak, nonatomic) IBOutlet UIButton *grabarCultivoArmario;
@property (weak, nonatomic) IBOutlet UIButton *calendarButton;
@property (weak, nonatomic) IBOutlet UITableView *armariosTable;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableWidth;

@property (nonatomic) CGFloat yPosition;

@property (nonatomic, strong) FechaSelectorViewController *fechaVC;
@property (nonatomic, strong) ErrorViewController *errorView;


@end

@implementation CultivoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Nuevo Cultivo";
    
    self.tableWidth.constant = self.view.frameWidth-20;
    
    [[self.notasText layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.notasText layer] setBorderWidth:1];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:[NSDate date]];
    
    self.fechaText.text =stringFromDate;
    
    self.notasText.text = NSLocalizedString(@"Agregue sus notas al cultivo", nil);
    self.notasText.textColor = [UIColor lightGrayColor];
    self.notasText.delegate = self;

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    self.errorView = [[UIStoryboard storyboardWithName:@"Help" bundle:nil]instantiateViewControllerWithIdentifier:@"ErrorVC"];
    [self addChildViewController:self.errorView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



-(void)cancelFecha{

    [self.fechaVC removeFromParentViewController];
    [self.fechaVC.view removeFromSuperview];

}

-(void)selectFecha:(NSDate*)fecha{

    [self.fechaVC removeFromParentViewController];
    [self.fechaVC.view removeFromSuperview];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:fecha];
    
    self.fechaText.text =stringFromDate;
    
}

- (IBAction)grabarCultivoTapped:(id)sender {
    
    [self saveCultivo];
    
}


- (IBAction)cancelarTapped:(id)sender {
        
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"agregarArmario"]) {
        ((ArmarioViewController*)segue.destinationViewController).delegate = self;
    }
}


-(void)saveCultivo
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *dateFromString = [[NSDate alloc] init];
    
    if ([self validaCamposCultivo])
    {
        if (!self.cultivo)
            self.cultivo = [Cultivo create];
        
        if ([self validaCultivo:self.cultivo])
        {
            self.cultivo.nombre = self.nombreText.text;
            self.cultivo.notas = self.notasText.text;
            self.cultivo.fechaInicio = dateFromString;
            
            [self.cultivo save];
            
            [self.delegate cultivoGrabado:self.cultivo];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }

}

-(BOOL)validaCamposCultivo
{
    BOOL result = YES;
    
    if (![self validarText:self.nombreText])
    {
        self.errorView.text = @"Hay campos que son obligatorios.";
        self.errorView.backColor = [UIColor redColor];
        [self.errorView showInView:self.view];
        
        result = NO;
    }
    
    return result;
}


-(BOOL)validaCultivo:(Cultivo*)cultivo
{
    BOOL result = YES;
    
    if (cultivo.armarios.count == 0)
    {
        self.errorView.text = @"Debe agregar al menos un armario.";
        self.errorView.backColor = [UIColor redColor];
        [self.errorView showInView:self.view];
        
        result = NO;
    }
    
    return result;
}

-(void)cancelAgregarArmario{
    
    
}

-(void)armarioAgregado:(Armario*)armario{
 
    if (!self.cultivo)
        self.cultivo = [Cultivo create];
    
    [self.cultivo addArmariosObject:armario];
    
    [self.armariosTable reloadData];
    
}


-(void)showPicker
{
    self.fechaVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"fechaPicker"];
    self.fechaVC.delegate = self;
    
    [self addChildViewController:self.fechaVC];
    [self.view addSubview:self.fechaVC.view];
    
    self.fechaVC.view.frameX = 0;
    self.fechaVC.view.frameHeight = 260;
    self.fechaVC.view.frameY = self.view.frameHeight -  self.fechaVC.view.frameHeight;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)aTextView
{
    aTextView.text = @"";

    self.yPosition = 180;
    
    return YES;
}

-(void)dismissKeyboard {
    [self.notasText resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return true;
}

-(void)keyboardWillShow {
    // Animate the current view out of the way
    [UIView animateWithDuration:0.3f animations:^ {
        self.view.frame = CGRectMake(0, -self.yPosition, 320, self.view.frame.size.height);
    }];
}

-(void)keyboardWillHide {
    // Animate the current view back to its original position
    [UIView animateWithDuration:0.3f animations:^ {
        self.view.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
    }];
}

- (IBAction)calendarTapped:(id)sender {
    
    [self showPicker];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.cultivo.armarios.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"armarioCell" forIndexPath:indexPath];
    
    Armario *armario = self.cultivo.armarios.allObjects[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - Plantas:%d", armario.nombre, armario.plantas.count];
    
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:15];
    
    return cell;
}



@end
