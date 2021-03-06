//
//  PlantaViewController.m
//  Maria
//
//  Created by Juan Escudero on 10/2/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "PlantaViewController.h"
#import "SelectorViewController.h"
#import "TipoPlanta.h"
#import "CicloVida.h"
#import "TipoPlanta.h"
#import "CicloVida.h"
#import "Planta.h"
#import "ErrorViewController.h"
#import "RepetirPlantaViewController.h"

@interface PlantaViewController ()<SelectorProtocol, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, RepetirPlantaDelegate>

@property (weak, nonatomic) IBOutlet UILabel *tipoPlantaLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipoSelectedLabel;
@property (weak, nonatomic) IBOutlet UILabel *cicloVidaLabel;
@property (weak, nonatomic) IBOutlet UILabel *cicloSelectedLabel;
@property (weak, nonatomic) IBOutlet UILabel *alturaLabel;
@property (weak, nonatomic) IBOutlet UITextField *alturaText;
@property (weak, nonatomic) IBOutlet UIButton *tipoPlantaButton;
@property (weak, nonatomic) IBOutlet UIButton *cicloVidaButton;
@property (weak, nonatomic) IBOutlet UIButton *grabarButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelarButton;
@property (weak, nonatomic) IBOutlet UITextField *geneticaText;

@property (nonatomic, strong) SelectorViewController *selector;
@property (nonatomic, strong) ErrorViewController *errorView;
@property (nonatomic, strong) RepetirPlantaViewController *repetirPlanceVC;


@property (nonatomic, strong) UIView *overlayView;
@property (weak, nonatomic) IBOutlet UIImageView *photo;


@property (nonatomic, strong) TipoPlanta *tipoPlanta;
@property (nonatomic, strong) CicloVida *ciclo;


@end

@implementation PlantaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Nueva Planta";
    // Do any additional setup after loading the view.
    
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
- (IBAction)grabarTapped:(id)sender {

    
    if ([self validaPlantayCiclo])
    {
        
        self.overlayView = [[UIView alloc]initWithFrame:self.view.frame];
        self.overlayView.backgroundColor = [UIColor blackColor];
        self.overlayView.alpha = 0.5;
        [self.view addSubview:self.overlayView];
        
        self.repetirPlanceVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"RepetirVC"];
        self.repetirPlanceVC.view.frame = CGRectMake(self.view.frameWidth/2 - 250/2, self.view.frameHeight/2 - 200/2, 250, 200);
        self.repetirPlanceVC.delegate = self;
        
        [self addChildViewController:self.repetirPlanceVC];
        [self.view addSubview:self.repetirPlanceVC.view];
        
    }
    
}

-(void)repetirPlanta:(NSInteger)num
{
    for (int i = 1; i<= num; i++) {
        Planta *planta = [Planta create];
        
        if ([self.alturaText.text isEqualToString:@""])
            planta.altura = [NSDecimalNumber decimalNumberWithString:@"0"];
        else
            planta.altura = [NSDecimalNumber decimalNumberWithString:self.alturaText.text];
        
        if ([self.geneticaText.text isEqualToString:@""])
            planta.genetica = @"NN";
        else
            planta.genetica = self.geneticaText.text;
        
        planta.tipoPlanta = self.tipoPlanta;
        planta.inicioCicloVida = self.ciclo;
        planta.foto = UIImagePNGRepresentation(self.photo.image);
        
        [self.delegate plantaAgregada:planta];
    }
    
    [self.navigationController popViewControllerAnimated:YES];

}

-(BOOL)validaPlantayCiclo
{
    BOOL result = YES;
    
    if (!(self.tipoPlanta && self.ciclo))
    {
        self.errorView.text = @"El Tipo de Planta y Ciclo de vida son obligatorios.";
        self.errorView.backColor = [UIColor redColor];
        [self.errorView showInView:self.view];
        
        result = NO;
    }
    
    return result;
}


- (IBAction)cancelarTapped:(id)sender {

    [self.delegate cancelAgregarPlanta];
}

- (IBAction)tipoDePlantaTapped:(id)sender {

    self.overlayView = [[UIView alloc]initWithFrame:self.view.frame];
    self.overlayView.backgroundColor = [UIColor blackColor];
    self.overlayView.alpha = 0.5;
    [self.view addSubview:self.overlayView];
    
    self.selector = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"TipoLuzVC"];
    self.selector.view.frame = CGRectMake(self.view.frame.size.width/2 - 300/2, 100, 300, 260);
    self.selector.delegate = self;
    self.selector.titleVC.text = @"Tipo de Luz";
    self.selector.property_first = @"tipoPlanta";
    self.selector.datasource = [TipoPlanta all];
    
    [self addChildViewController:self.selector];
    [self.view addSubview:self.selector.view];
    
}

- (IBAction)cicloVidaTapped:(id)sender {

    self.overlayView = [[UIView alloc]initWithFrame:self.view.frame];
    self.overlayView.backgroundColor = [UIColor blackColor];
    self.overlayView.alpha = 0.5;
    [self.view addSubview:self.overlayView];
    
    self.selector = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"TipoLuzVC"];
    self.selector.view.frame = CGRectMake(self.view.frame.size.width/2 - 300/2, 100, 300, 260);
    self.selector.delegate = self;
    self.selector.titleVC.text = @"Ciclo de Vida";
    self.selector.property_first = @"nombre";
    self.selector.datasource = [CicloVida all];
    
    [self addChildViewController:self.selector];
    [self.view addSubview:self.selector.view];
}

-(void)cancelSeleccion{
    
    [self.overlayView removeFromSuperview];
    
    [self.selector removeFromParentViewController];
    [self.selector.view removeFromSuperview];
}

-(void)selectElement:(id)element{

    if ( [(NSStringFromClass([element class])) isEqual:NSStringFromClass([TipoPlanta class])])
    {
        self.tipoPlanta = (TipoPlanta*)element;
        self.tipoSelectedLabel.text = [NSString stringWithFormat:@"%@", self.tipoPlanta.tipoPlanta];
    }
    else
    {
        self.ciclo = (CicloVida*)element;
        self.cicloSelectedLabel.text = [NSString stringWithFormat:@"%@", self.ciclo.nombre];
    }
    

    [self.overlayView removeFromSuperview];

    [self.selector removeFromParentViewController];
    [self.selector.view removeFromSuperview];
}

- (IBAction)fotoTapped:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    picker.showsCameraControls = YES;

    [self presentViewController:picker animated:YES completion:NULL];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.photo.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return true;
}

@end
