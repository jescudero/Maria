//
//  Riego.h
//  Maria
//
//  Created by Juan Escudero on 10/24/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Riego : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * ec;
@property (nonatomic, retain) NSString * nota;
@property (nonatomic, retain) NSDecimalNumber * ph;
@property (nonatomic, retain) NSDecimalNumber * temperatura;
@property (nonatomic, retain) NSDecimalNumber * litros;

@end
