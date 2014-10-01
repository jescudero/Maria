//
//  NSManagedObject+Requests.h
//  Equinox
//
//  Created by Pedro Mancheno on 12/11/13.
//  Copyright (c) 2013 rga. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (Requests)

+ (NSFetchRequest *) createFetchRequestInContext:(NSManagedObjectContext *)context;

+ (NSFetchRequest *) requestAllWithPredicate:(NSPredicate *)searchTerm
                                   inContext:(NSManagedObjectContext *)context;

@end
