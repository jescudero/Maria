//
//  NSManagedObject+Finders.h
//  Equinox
//
//  Created by Pedro Mancheno on 12/11/13.
//  Copyright (c) 2013 rga. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (Finders)

+ (NSArray *)findAllInContext:(NSManagedObjectContext *)context
                    withError:(NSError **)pError;

+ (NSArray *)findAllIdsInContext:(NSManagedObjectContext *)context
                       withError:(NSError **)pError;

+ (NSArray *)findAllWithPredicate:(NSPredicate *)predicate
                        inContext:(NSManagedObjectContext *)context
                        withError:(NSError **)pError;

+ (NSArray *)findAllWithPredicate:(NSPredicate *)predicate
                         sortedBy:(NSString *)sortKey
                        ascending:(BOOL)ascending
                        inContext:(NSManagedObjectContext *)context
                        withError:(NSError **)pError;

+ (NSArray *)findAllWithContext:(NSManagedObjectContext *)context
                     whereField:(NSString *)fieldName
                         equals:(id)value
                      withError:(NSError **)pError;// __attribute__((deprecated));

+ (NSArray *)findAllWhereField:(NSString *)fieldName
                        equals:(id)value
                     inContext:(NSManagedObjectContext *)context
                     withError:(NSError **)pError;

+ (NSArray *)findAllWhereField:(NSString *)fieldName
                          isIn:(id<NSFastEnumeration>)collection
                     inContext:(NSManagedObjectContext *)context
                     withError:(NSError **)pError;

+ (NSArray *)findAllWithPredicate:(NSPredicate *)predicate
            andRetrieveAttributes:(NSArray *)attributes
                        inContext:(NSManagedObjectContext *)context
                        withError:(NSError **)pError;

+ (NSArray *)findAllAndRetrievedAttributes:(NSArray *)attributes
                                whereField:(NSString *)fieldName
                                    equals:(id)value
                                 inContext:(NSManagedObjectContext *)context
                                 withError:(NSError **)pError;

+ (NSArray *)findDistinctValuesOfAttribute:(NSString *)attribute
                             withPredicate:(NSPredicate *) predicate
                           sortedAscending:(BOOL)ascending
                                 inContext:(NSManagedObjectContext *)context
                                 withError:(NSError **)pError;

+ (instancetype)anyInCurrentContext;

+ (instancetype)anyInManagedObjectContext:(NSManagedObjectContext *)moc;


@end
