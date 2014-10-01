//
//  DataManager.m
//  Maria
//
//  Created by Juan Escudero on 10/1/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "DataManager.h"
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

#import "Luces.h"
#import "Armario.h"

@implementation DataManager

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(void)createApplicationObjects{

    if (![self isDataSaved])
        [self createTipoLuz];
    
}

-(BOOL)isDataSaved;
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription  entityForName:@"Luces" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    NSError *error;
    
    NSArray *array = [context executeFetchRequest:request error:&error];
    
    return array.count > 0;
}

-(void)createTipoLuz
{

    NSManagedObjectContext *context = [self managedObjectContext];
    
    Luces *luz1 = [NSEntityDescription insertNewObjectForEntityForName:@"Luces" inManagedObjectContext:context];
    luz1.tipo = @"Halogeno";
    luz1.watts = [NSDecimalNumber decimalNumberWithString:@"250.0"];
    
    Luces *luz2 = [NSEntityDescription insertNewObjectForEntityForName:@"Luces" inManagedObjectContext:context];
    luz2.tipo = @"Halogeno";
    luz2.watts = [NSDecimalNumber decimalNumberWithString:@"400.0"];
    
    Luces *luz3 = [NSEntityDescription insertNewObjectForEntityForName:@"Luces" inManagedObjectContext:context];
    luz3.tipo = @"Halogeno";
    luz3.watts = [NSDecimalNumber decimalNumberWithString:@"150.0"];
    
    Luces *luz4 = [NSEntityDescription insertNewObjectForEntityForName:@"Luces" inManagedObjectContext:context];
    luz4.tipo = @"Sodio";
    luz4.watts = [NSDecimalNumber decimalNumberWithString:@"150.0"];
    
    Luces *luz5 = [NSEntityDescription insertNewObjectForEntityForName:@"Luces" inManagedObjectContext:context];
    luz5.tipo = @"Sodio";
    luz5.watts = [NSDecimalNumber decimalNumberWithString:@"250.0"];
    
    Luces *luz6 = [NSEntityDescription insertNewObjectForEntityForName:@"Luces" inManagedObjectContext:context];
    luz6.tipo = @"Sodio";
    luz6.watts = [NSDecimalNumber decimalNumberWithString:@"400.0"];
    
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }

}


-(NSArray *)getTiposDeLuz{

    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription  entityForName:@"Luces" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    NSError *error;
    
    NSArray *array = [context executeFetchRequest:request error:&error];
    
    return array;
}

-(void)almacenarArmario:(Armario*)armario
{
    NSManagedObjectContext *context = [self managedObjectContext];


    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
}

@end
