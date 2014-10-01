//
//  NSManagedObject+Finders.m
//  Equinox
//
//  Created by Pedro Mancheno on 12/11/13.
//  Copyright (c) 2013 rga. All rights reserved.
//

#import "NSManagedObject+Finders.h"
#import "NSManagedObject+Requests.h"
#import "CoreDataHelper.h"

@implementation NSManagedObject (Finders)

+ (NSArray *)findAllInContext:(NSManagedObjectContext *)context
                    withError:(NSError **)pError
{
    NSFetchRequest* fetchRequest = [self createFetchRequestInContext:context];
    return [context executeFetchRequest:fetchRequest error:pError];
}

+ (NSArray *)findAllIdsInContext:(NSManagedObjectContext *)context
                       withError:(NSError **)pError
{
    NSFetchRequest* fetchRequest = [self createFetchRequestInContext:context];
    [fetchRequest setIncludesPropertyValues:NO]; 
    return [context executeFetchRequest:fetchRequest error:pError];
}

+ (NSArray *)findAllWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context withError:(NSError **)pError
{
    NSFetchRequest* fetchRequest = [self requestAllWithPredicate:predicate inContext:context];
    return [context executeFetchRequest:fetchRequest error:pError];
}

+ (NSArray *)findAllWithPredicate:(NSPredicate *)predicate
                         sortedBy:(NSString *)sortKey
                        ascending:(BOOL)ascending
                        inContext:(NSManagedObjectContext *)context
                        withError:(NSError **)pError
{
    NSFetchRequest* fetchRequest = [self requestAllWithPredicate:predicate inContext:context];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:sortKey ascending:ascending]];
    
    return [context executeFetchRequest:fetchRequest error:pError];
}

+ (NSArray *)findAllWithContext:(NSManagedObjectContext *)context
                     whereField:(NSString *)fieldName
                         equals:(id)value
                      withError:(NSError **)pError
{
    return [self findAllWhereField:fieldName equals:value inContext:context withError:pError];
}
+ (NSArray *)findAllWhereField:(NSString *)fieldName
                        equals:(id)value
                     inContext:(NSManagedObjectContext *)context
                     withError:(NSError **)pError;
{
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"%K == %@", fieldName, value];
    return [self findAllWithPredicate:predicate inContext:context withError:pError];
}

+ (NSArray *)findAllWhereField:(NSString *)fieldName
                          isIn:(id<NSFastEnumeration>)collection
                     inContext:(NSManagedObjectContext *)context
                     withError:(NSError **)pError
{
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"%K IN %@", fieldName, collection];
    return [self findAllWithPredicate:predicate inContext:context withError:pError];
}

+ (NSArray *)findAllWithPredicate:(NSPredicate *)predicate
            andRetrieveAttributes:(NSArray *)attributes
                        inContext:(NSManagedObjectContext *)context
                        withError:(NSError **)pError
{
    NSFetchRequest* fetchRequest = [self requestAllWithPredicate:predicate inContext:context ];
    [fetchRequest setResultType:NSDictionaryResultType];
    [fetchRequest setPropertiesToFetch:attributes];
    [fetchRequest setPredicate:predicate];
    
    return [context executeFetchRequest:fetchRequest error:pError];
}

+ (NSArray *)findAllAndRetrievedAttributes:(NSArray *)attributes
                                whereField:(NSString *)fieldName
                                    equals:(id)value
                                 inContext:(NSManagedObjectContext *)context
                                 withError:(NSError **)pError {
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"%K == %@", fieldName, value];
    return [self findAllWithPredicate:predicate andRetrieveAttributes:attributes inContext:context withError:pError];
}

+ (NSArray *)findDistinctValuesOfAttribute:(NSString *)attribute
                             withPredicate:(NSPredicate *) predicate
                           sortedAscending:(BOOL)ascending
                                 inContext:(NSManagedObjectContext *)context
                                 withError:(NSError **)pError
{
    // create the fetch request and set the attributes of the request based on the given parameters
    NSFetchRequest* fetchRequest = [self requestAllWithPredicate:predicate inContext:context ];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:attribute
                                                                   ascending:ascending];
    
    [fetchRequest setResultType:NSDictionaryResultType];
    [fetchRequest setPropertiesToFetch:@[attribute]];
    [fetchRequest setReturnsDistinctResults:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // execute the fetch, result is returned in an array of dictionaries
    NSArray * attributeArray = [context executeFetchRequest:fetchRequest error:pError];
    
    return [attributeArray valueForKey:attribute];
}

+ (instancetype)anyInCurrentContext
{
    return [self anyInManagedObjectContext:[[CoreDataHelper sharedInstance] managedObjectContext]];
}

+ (instancetype)anyInManagedObjectContext:(NSManagedObjectContext *)moc
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:[[self class] description] inManagedObjectContext:moc];
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchLimit:1];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:fetchRequest error:&error];
    
    if ([results count]) {
        return results[0];
    }
    else {
        return nil;
    }
}



@end
